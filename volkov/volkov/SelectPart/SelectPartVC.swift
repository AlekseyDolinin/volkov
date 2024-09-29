import UIKit

class SelectPartVC: GeneralViewController {

    private var table = UITableView()
    private var header = HeaderSelectPart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.setView()
    }
    
    private func showListFilteredPerformance() {
        DispatchQueue.main.async {
            let vc = FilteredPerformanceVC()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }
    }
}


extension SelectPartVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPartCell", for: indexPath) as! SelectPartCell
        cell.nameScene = LocalStorage.shared.listScenes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = SelectMarkVC(typeSelectMark: .multi)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SelectPartVC {
    
    private func createSubviews() {
        createTable()
    }
    
    private func createTable() {
        view.addSubview(table)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.keyboardDismissMode = .onDrag
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        table.register(SelectPartCell.self, forCellReuseIdentifier: "SelectPartCell")
        table.tableHeaderView = header
        table.createClearFooter()
        //
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
