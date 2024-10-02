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
    
    init(selectScene: Scene, selectCategory: Category) {
        super.init(nibName: nil, bundle: nil)
        self.selectScene = selectScene
        self.selectCategory = selectCategory
        header.selectScene = selectScene
        header.selectCategory = selectCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.setView()
    }
    
    private func checkSelectTagForShowButtonSave() {
        let selected = selectCategory.tags.map({ $0.isSelect })
        if selected.contains(true) {
            saveTagButton.alpha = 1
            saveTagButton.isEnabled = true
        } else {
            saveTagButton.alpha = 0.2
            saveTagButton.isEnabled = false
        }
        
        
//        let selectMarks = selected.filter({ $0 == true })
//        if selectMarks.contains(true) {
//            sendTagButton.alpha = 1
//            sendTagButton.isEnabled = true
//        } else {
//            sendTagButton.alpha = 0.2
//            sendTagButton.isEnabled = false
//        }
    }
    
    private func selectMark(indexPath: IndexPath) {
        
        
//        let item = LocalStorage.shared.marks[indexPath.row]
//        if let isSelect: Bool = item["select"] as? Bool {
//            LocalStorage.shared.marks[indexPath.row]["select"] = !isSelect
//            table.reloadRows(at: [indexPath], with: .none)
//            checkSelectMark()
//        }
        
//        if vm.typeSelectMark == .multi {
//            let item = LocalStorage.shared.marks[indexPath.row]
//            if let isSelect: Bool = item["select"] as? Bool {
//                LocalStorage.shared.marks[indexPath.row]["select"] = !isSelect
//                table.reloadRows(at: [indexPath], with: .none)
//                checkSelectMark()
//            }
//        }
//        
//        if vm.typeSelectMark == .single {
//            for i in 0..<LocalStorage.shared.marks.count {
//                LocalStorage.shared.marks[i]["select"] = false
//            }
//            table.reloadData()
//            LocalStorage.shared.marks[indexPath.row]["select"] = true
//            table.reloadRows(at: [indexPath], with: .none)
//            checkSelectMark()
//        }
        
        selectCategory.tags[indexPath.row].isSelect.toggle()
        table.reloadRows(at: [indexPath], with: .none)
        checkSelectTagForShowButtonSave()
    }
    
    private func saveTags() {
        let selectedTags = selectCategory.tags.filter({ $0.isSelect == true })
        let selectedIDsTags = selectedTags.map({ $0.id })
        //
        let arrayLaterSavedTags: [Int] = LocalStorage.shared.savedIDsTags ?? []
        LocalStorage.shared.savedIDsTags = arrayLaterSavedTags + selectedIDsTags
        dismiss(animated: true)
    }
}


extension SelectTagVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectCategory.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTagCell.identifier,
                                                       for: indexPath) as? SelectTagCell else {
            fatalError("Unable deque cell...")
        }
        cell.tag_ = selectCategory.tags[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMark(indexPath: indexPath)
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
        topView.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
        closeButton.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
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
