import UIKit

class SelectMarkVC: GeneralViewController {

    private var table = UITableView()
    private var header = HeaderSelectMark()
    private let sendMarkButton = UIButton()
    
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
        print("sendMarkAction")
//        DispatchQueue.main.async {
//            let vc = FilteredPerformanceVC()
//            vc.modalPresentationStyle = .pageSheet
//            self.present(vc, animated: true)
//        }
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
        let item = LocalStorage.shared.marks[indexPath.row]
        if let isSelect: Bool = item["select"] as? Bool {
            LocalStorage.shared.marks[indexPath.row]["select"] = !isSelect
            table.reloadRows(at: [indexPath], with: .none)
        }
        checkSelectMark()
    }
    
}


extension SelectMarkVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorage.shared.marks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectMarkCell", for: indexPath) as! SelectMarkCell
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
        sendMarkButton.setTitle("Сохранить метку", for: .normal)
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
