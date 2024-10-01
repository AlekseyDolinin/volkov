//import UIKit
//
//class FilteredPerformanceVC: UIViewController {
//
//    private var table = UITableView()
//    private var header = HeaderFilteredPerformance()
//    private let closeButton = UIButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        createSubviews()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        header.setView()
//    }
//}
//
//
//extension FilteredPerformanceVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return LocalStorage.shared.listPerformances.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PerformanceCell", for: indexPath) as! PerformanceCell
//        cell.namePerformance = LocalStorage.shared.listPerformances[indexPath.row]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(LocalStorage.shared.listPerformances[indexPath.row])
//    }
//}
//
//
//extension FilteredPerformanceVC {
//    
//    private func createSubviews() {
//        createTable()
//        createCloseButton()
//    }
//    
//    private func createTable() {
//        view.addSubview(table)
//        table.backgroundColor = .clear
//        table.separatorColor = .clear
//        table.keyboardDismissMode = .onDrag
//        table.showsVerticalScrollIndicator = false
//        table.delegate = self
//        table.dataSource = self
//        table.register(PerformanceCell.self, forCellReuseIdentifier: "PerformanceCell")
//        table.tableHeaderView = header
//        table.createClearFooter()
//        //
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//    }
//    
//    private func createCloseButton() {
//        view.addSubview(closeButton)
//        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        closeButton.layer.cornerRadius = 8
//        closeButton.setTitleColor(.white, for: .normal)
//        closeButton.backgroundColor = .white
//        closeButton.setTitle("Закрыть", for: .normal)
//        let action = UIAction { [weak self] _ in
//            DispatchQueue.main.async {
//                self?.dismiss(animated: true)
//            }
//        }
//        closeButton.addAction(action, for: .touchUpInside)
//        //
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
//        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
//        closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
//        closeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
//    }
//}
