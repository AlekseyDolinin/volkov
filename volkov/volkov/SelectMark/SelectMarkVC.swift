import UIKit

class SelectMarkVC: GeneralViewController {

    private var vm: SelectMarkVM!
    
    private var table = UITableView()
    private var header = HeaderSelectMark()
    private let sendMarkButton = UIButton()
    
    init(typeSelectMark: TypeSelectMark) {
        super.init(nibName: nil, bundle: nil)
        vm = SelectMarkVM()
        vm.typeSelectMark = typeSelectMark
        vm.delegate = self
        header.typeSelectMark = typeSelectMark
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
        /// TEMP
        for i in 0..<LocalStorage.shared.marks.count {
            LocalStorage.shared.marks[i]["select"] = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.setView()
    }
    
    private func sendMarkAction() {
        let title = vm.typeSelectMark == .multi ? "Сохранить выбранные метки?" : "Сохранить выбранную метку?"
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { action  in
            self.showLoader()
            self.vm.saveMarks()
        }))
        present(alert, animated: true)
    }
    
    private func checkSelectMark() {
        let selected: [Bool?] = LocalStorage.shared.marks.map( { $0["select"] as? Bool})
        let selectMarks = selected.filter({ $0 == true })
        if selectMarks.contains(true) {
            sendMarkButton.alpha = 1
            sendMarkButton.isEnabled = true
        } else {
            sendMarkButton.alpha = 0.2
            sendMarkButton.isEnabled = false
        }
    }
    
    private func selectMark(indexPath: IndexPath) {
        
        if vm.typeSelectMark == .multi {
            let item = LocalStorage.shared.marks[indexPath.row]
            if let isSelect: Bool = item["select"] as? Bool {
                LocalStorage.shared.marks[indexPath.row]["select"] = !isSelect
                table.reloadRows(at: [indexPath], with: .none)
                checkSelectMark()
            }
        }
        
        if vm.typeSelectMark == .single {
            for i in 0..<LocalStorage.shared.marks.count {
                LocalStorage.shared.marks[i]["select"] = false
            }
            table.reloadData()
            LocalStorage.shared.marks[indexPath.row]["select"] = true
            table.reloadRows(at: [indexPath], with: .none)
            checkSelectMark()
        }
    }
    
}


extension SelectMarkVC: SelectMarkVMDelegate {
                            
    func updateContent() {
        print("updateContent")
    }
    
    func saveMarkSucces() {
        print("saveMarkSucces")
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.0) {
            self.hideLoader()
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension SelectMarkVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorage.shared.marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMarkCell", for: indexPath) as! SelectMarkCell
        cell.typeSelectMark = vm.typeSelectMark
        let item = LocalStorage.shared.marks[indexPath.row]
        if let isSelect = item["select"] as? Bool, let name = item["name"] as? String {
            cell.isSelect = isSelect
            cell.nameMark = name
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMark(indexPath: indexPath)
    }
}


extension SelectMarkVC {
    
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
        table.register(SelectMarkCell.self, forCellReuseIdentifier: "SelectMarkCell")
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
        view.addSubview(sendMarkButton)
        sendMarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        sendMarkButton.layer.cornerRadius = 8
        sendMarkButton.setTitleColor(.white, for: .normal)
        sendMarkButton.backgroundColor = darkBlue
        sendMarkButton.alpha = 0.2
        sendMarkButton.isEnabled = false
        let title = vm.typeSelectMark == .multi ? "Сохранить метки" : "Сохранить метку"
        sendMarkButton.setTitle(title, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.sendMarkAction()
        }
        sendMarkButton.addAction(action, for: .touchUpInside)
        //
        sendMarkButton.translatesAutoresizingMaskIntoConstraints = false
        sendMarkButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        sendMarkButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sendMarkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        sendMarkButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
