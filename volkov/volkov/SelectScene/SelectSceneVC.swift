import UIKit

class SelectSceneVC: GeneralViewController {

    private var table = UITableView()
    private var header = HeaderSelectScene()
    private let filterPerformanceButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.setView()
        setFilterPerformanceButton()
    }
    
    private func setFilterPerformanceButton() {
        let listPerformances = LocalStorage.shared.listPerformances
        let title = "Подходят \(listPerformances.count) постановок"
        filterPerformanceButton.setTitle(title, for: .normal)
    }
    
    private func showListFilteredPerformance() {
        DispatchQueue.main.async {
            let vc = FilteredPerformanceVC()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true)
        }
    }
}


extension SelectSceneVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorage.shared.listScenes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SceneCell", for: indexPath) as! SceneCell
        cell.nameScene = LocalStorage.shared.listScenes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                let vc = SelectPartVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let vc = SelectMarkVC(typeSelectMark: .single)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension SelectSceneVC {
    
    private func createSubviews() {
        createTable()
        createFilterPerformanceButton()
    }
    
    private func createTable() {
        view.addSubview(table)
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.keyboardDismissMode = .onDrag
        table.showsVerticalScrollIndicator = false
        table.delegate = self
        table.dataSource = self
        table.register(SceneCell.self, forCellReuseIdentifier: "SceneCell")
        table.tableHeaderView = header
        table.createClearFooter()
        //
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func createFilterPerformanceButton() {
        view.addSubview(filterPerformanceButton)
        filterPerformanceButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        filterPerformanceButton.layer.cornerRadius = 8
        filterPerformanceButton.setTitleColor(.white, for: .normal)
        filterPerformanceButton.backgroundColor = darkBlue
        let action = UIAction { [weak self] _ in
            self?.showListFilteredPerformance()
        }
        filterPerformanceButton.addAction(action, for: .touchUpInside)
        //
        filterPerformanceButton.translatesAutoresizingMaskIntoConstraints = false
        filterPerformanceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        filterPerformanceButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        filterPerformanceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        filterPerformanceButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
