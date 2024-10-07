import UIKit

class SelectTagVC: GeneralViewController {
    
    private var topView = UIView()
    private var closeButton = UIButton()
    private let titlePrimery = UILabel()
    private var collection: UICollectionView!
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
        collection.reloadData()
    }
    
    private func setMulti(indexPath: IndexPath, maxCount: Int) {
        print("maxCount: \(maxCount)")
        
        // если ничего ещё не выбрали
        if selectTagsIDThisCategory.isEmpty {
            selectTagsIDThisCategory.append(selectCategory.tags[indexPath.row].id)
            collection.reloadItems(at: [indexPath])
            return
        }
        
        // если уже что-то выбрали и нажали на уже выбраный тэг - удаление тэга из списка выбраных
        if !selectTagsIDThisCategory.isEmpty && selectTagsIDThisCategory.contains(selectCategory.tags[indexPath.row].id) {
            print("нажали на уже выбраный тэг")
            guard let index = selectTagsIDThisCategory.firstIndex(of: selectCategory.tags[indexPath.row].id) else { return }
            selectTagsIDThisCategory.remove(at: index)
            collection.reloadItems(at: [indexPath])
            return
        }
        
        // если уже что-то выбрали и нажали на не выбраный тэг
        if !selectTagsIDThisCategory.isEmpty && !selectTagsIDThisCategory.contains(selectCategory.tags[indexPath.row].id) {
            // проверка лимита на количество тэгов
            if selectTagsIDThisCategory.count == maxCount { return }
            print("нажали на не выбраный тэг")
            selectTagsIDThisCategory.append(selectCategory.tags[indexPath.row].id)
            collection.reloadItems(at: [indexPath])
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


extension SelectTagVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectCategory.tags.count
    }

    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectTagCell.identifier,
            for: indexPath
        ) as? SelectTagCell  else {
            fatalError("Unable deque cell...")
        }
        cell.selectTagsIDThisCategory = selectTagsIDThisCategory
        cell.tag_ = selectCategory.tags[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 24) / 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectTag(indexPath: indexPath)
    }
}


extension SelectTagVC {
    
    private func createSubviews() {
        createTopView()
        createCloseButton()
        createTitle()
        createBottomView()
        createSendMarkButton()
        createCollection()
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
    
    private func createTitle() {
        view.addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titlePrimery.textColor = .white
        titlePrimery.lineBreakMode = .byWordWrapping
        titlePrimery.numberOfLines = 0
        titlePrimery.textAlignment = .center
        titlePrimery.text = selectCategory.name
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titlePrimery.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
    
    private func createCollection() {
        collection = UICollectionView(frame: .zero, collectionViewLayout: setLayoutCollection())
        view.addSubview(collection)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(SelectTagCell.self, forCellWithReuseIdentifier: SelectTagCell.identifier)        
        //
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: titlePrimery.bottomAnchor).isActive = true
        collection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
    }
    
    private func setLayoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 8)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.scrollDirection = .vertical
        return layout
    }
}
