import UIKit

class SelectTagVC: GeneralViewController {
    
    private var topView = UIView()
    private var closeButton = UIButton()
    private var table = UITableView()
    private var header = HeaderSelectTag()
    private var bottomView = UIView()
    private let saveTagButton = UIButton()
    
    private var selectScene: Scene!
    private var selectCategory: Category!
    
    private var selectTagsIDThisCategory = [Int]()
    
    init(selectScene: Scene, selectCategory: Category) {
        super.init(nibName: nil, bundle: nil)
        self.selectScene = selectScene
        self.selectCategory = selectCategory
        header.selectScene = selectScene
        header.selectCategory = selectCategory
        header.setView()
        
        let tagsIDThisCategory: Set<Int> = Set(selectCategory.tags.map({ $0.id }))
        let savedIDsTags: Set<Int> = Set(LocalStorage.shared.savedIDsTags)
        selectTagsIDThisCategory = Array(tagsIDThisCategory.intersection(savedIDsTags))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
    }
    
    private func checkSelectTagForShowButtonSave() {
        if selectTagsIDThisCategory.isEmpty {
            saveTagButton.alpha = 0.2
            saveTagButton.isEnabled = false
        } else {
            saveTagButton.alpha = 1
            saveTagButton.isEnabled = true
        }
    }
    
    private func selectTag(indexPath: IndexPath) {
        if let maxSelect = LocalStorage.shared.categoryMultiSelect[selectCategory.code] {
            setMulti(indexPath: indexPath, maxCount: maxSelect)
        } else {
            setSingle(indexPath: indexPath)
        }
        checkSelectTagForShowButtonSave()
    }
    
    private func setSingle(indexPath: IndexPath) {
        selectTagsIDThisCategory.removeAll()
        selectTagsIDThisCategory.append(selectCategory.tags[indexPath.row].id)
        table.reloadData()
    }
    
    private func setMulti(indexPath: IndexPath, maxCount: Int) {
        print("maxCount: \(maxCount)")
        
        // если ничего ещё не выбрали
        if selectTagsIDThisCategory.isEmpty {
            selectTagsIDThisCategory.append(selectCategory.tags[indexPath.row].id)
            table.reloadRows(at: [indexPath], with: .none)
            return
        }
        
        // если уже что-то выбрали и нажали на уже выбраный тэг - удаление тэга из списка выбраных
        if !selectTagsIDThisCategory.isEmpty && selectTagsIDThisCategory.contains(selectCategory.tags[indexPath.row].id) {
            print("нажали на уже выбраный тэг")
            guard let index = selectTagsIDThisCategory.firstIndex(of: selectCategory.tags[indexPath.row].id) else { return }
            selectTagsIDThisCategory.remove(at: index)
            table.reloadRows(at: [indexPath], with: .none)
            return
        }
        
        // если уже что-то выбрали и нажали на не выбраный тэг
        if !selectTagsIDThisCategory.isEmpty && !selectTagsIDThisCategory.contains(selectCategory.tags[indexPath.row].id) {
            // проверка лимита на количество тэгов
            if selectTagsIDThisCategory.count == maxCount { return }
            print("нажали на не выбраный тэг")
            selectTagsIDThisCategory.append(selectCategory.tags[indexPath.row].id)
            table.reloadRows(at: [indexPath], with: .none)
            return
        }
    }
        
    private func saveTags() {
        removeAllTagsThisCategory()
        saveNewTags()
    }
    
    // удаление из сохраненных меток всех меток этой категории
    private func removeAllTagsThisCategory() {
        // удаление из сохраненных меток всех меток этой категории
        for i in selectCategory.tags.map({ $0.id }) {
            LocalStorage.shared.savedIDsTags = LocalStorage.shared.savedIDsTags.filter({ $0 != i })
        }
    }
    
    // запись новых меток
    private func saveNewTags() {
        LocalStorage.shared.savedIDsTags += selectTagsIDThisCategory
        dismiss(animated: true)
    }
}


extension SelectTagVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectCategory.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SelectTagCell.identifier,
            for: indexPath) as? SelectTagCell else {
            fatalError("Unable deque cell...")
        }
        cell.selectTagsIDThisCategory = selectTagsIDThisCategory
        cell.tag_ = selectCategory.tags[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectTag(indexPath: indexPath)
    }
}


extension SelectTagVC {
    
    private func createSubviews() {
        createTopView()
        createCloseButton()
        createBottomView()
        createSendMarkButton()
        createTable()
    }
    
    private func createTopView() {
        view.addSubview(topView)
        topView.backgroundColor = gold
        //
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createCloseButton() {
        topView.addSubview(closeButton)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
        //
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .black
        //
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createSendMarkButton() {
        bottomView.addSubview(saveTagButton)
        saveTagButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        saveTagButton.layer.cornerRadius = 8
        saveTagButton.setTitleColor(.black, for: .normal)
        saveTagButton.backgroundColor = gold
        saveTagButton.alpha = 0.2
        saveTagButton.isEnabled = false
        saveTagButton.setTitle("Сохранить выбор", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.saveTags()
        }
        saveTagButton.addAction(action, for: .touchUpInside)
        //
        saveTagButton.translatesAutoresizingMaskIntoConstraints = false
        saveTagButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 16).isActive = true
        saveTagButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -16).isActive = true
        saveTagButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        saveTagButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        saveTagButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func createTable() {
        view.addSubview(table)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.keyboardDismissMode = .onDrag
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        table.register(SelectTagCell.self, forCellReuseIdentifier: SelectTagCell.identifier)
        table.tableHeaderView = header
        table.createClearFooter()
        //
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
}
