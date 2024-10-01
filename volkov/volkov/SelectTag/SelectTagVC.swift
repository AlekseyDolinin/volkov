import UIKit

class SelectTagVC: GeneralViewController {

    private var vm: SelectTagVM!
    
    private var table = UITableView()
    private var header = HeaderSelectTag()
    private let sendTagButton = UIButton()
    
    init(selectScene: Scene, selectCategory: Category) {
        super.init(nibName: nil, bundle: nil)
        vm = SelectTagVM()
        vm.delegate = self
        vm.selectScene = selectScene
        vm.selectCategory = selectCategory
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
    
    private func sendMarkAction() {
//        let title = vm.typeSelectMark == .multi ? "Сохранить выбранные метки?" : "Сохранить выбранную метку?"
        let alert = UIAlertController(title: "Сохранить выбранные метки?",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { action  in
            self.showLoader()
            self.vm.saveTags()
        }))
        present(alert, animated: true)
    }
    
    private func checkSelectMark() {
        
        
//        
        
        let selected = vm.selectCategory.tags.map({ $0.isSelect })
        
        print(selected)
        
        if selected.contains(true) {
            sendTagButton.alpha = 1
            sendTagButton.isEnabled = true
        } else {
            sendTagButton.alpha = 0.2
            sendTagButton.isEnabled = false
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
        
        print("!!!!!!")
        vm.selectCategory.tags[indexPath.row].isSelect.toggle()
        table.reloadRows(at: [indexPath], with: .none)
        checkSelectMark()
    }
    
}


extension SelectTagVC: SelectTagVMDelegate {
                            
    func updateContent() {
        print("updateContent")
    }
    
    func saveTagsSucces() {
        print("saveMarkSucces")
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            self.hideLoader()
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension SelectTagVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.selectCategory.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTagCell.identifier,
                                                       for: indexPath) as? SelectTagCell else {
            fatalError("Unable deque cell...")
        }
        cell.tag_ = vm.selectCategory.tags[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMark(indexPath: indexPath)
    }
}


extension SelectTagVC {
    
    private func createSubviews() {
        createTable()
        createSendMarkButton()
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
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createSendMarkButton() {
        view.addSubview(sendTagButton)
        sendTagButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        sendTagButton.layer.cornerRadius = 8
        sendTagButton.setTitleColor(.black, for: .normal)
        sendTagButton.backgroundColor = gold
        sendTagButton.alpha = 0.2
        sendTagButton.isEnabled = false
//        let title = vm.typeSelectMark == .multi ? "Сохранить метки" : "Сохранить метку"
        sendTagButton.setTitle("Сохранить метки", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.sendMarkAction()
        }
        sendTagButton.addAction(action, for: .touchUpInside)
        //
        sendTagButton.translatesAutoresizingMaskIntoConstraints = false
        sendTagButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sendTagButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sendTagButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        sendTagButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
