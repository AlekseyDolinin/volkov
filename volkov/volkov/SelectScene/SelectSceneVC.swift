import UIKit

class SelectSceneVC: GeneralViewController {

    private var vm: SelectSceneVM!
    
    private var table = UITableView()
    private var header = HeaderSelectScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = SelectSceneVM()
        vm?.delegate = self
        vm?.parseData()
        view.backgroundColor = .white
        createSubviews()
        header.layoutIfNeeded()
    }
    
    private func selectScene(index: Int) {
        let countPartInSelectScene = vm.scenes[index].categories.count
        countPartInSelectScene == 1 ? presentSelectTags(selectScene: vm.scenes[index]) : presentSelectPart(selectScene: vm.scenes[index])
    }
    
    private func presentSelectPart(selectScene: Scene) {
        DispatchQueue.main.async {
            let vc = SelectCategoryVC(selectScene: selectScene)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func presentSelectTags(selectScene: Scene) {
        DispatchQueue.main.async {
            if let selectCategory = selectScene.categories.first {
                let vc = SelectTagVC(selectScene: selectScene, selectCategory: selectCategory)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension SelectSceneVC: SelectSceneVMDelegate {
    
    func updateContent() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}


extension SelectSceneVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return vm.scenes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SceneCell.identifier, 
                                                       for: indexPath) as? SceneCell else {
            fatalError("Unable deque cell...")
        }
        cell.scene = vm.scenes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectScene(index: indexPath.row)
    }
}


extension SelectSceneVC {
    
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
        table.register(SceneCell.self, forCellReuseIdentifier: SceneCell.identifier)
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
