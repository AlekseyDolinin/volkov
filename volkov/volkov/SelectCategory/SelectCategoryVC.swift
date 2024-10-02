import UIKit

class SelectCategoryVC: GeneralViewController {

    private var table = UITableView()
    private var header = HeaderSelectCategory()
    
    var selectScene: Scene!
    
    init(selectScene: Scene) {
        super.init(nibName: nil, bundle: nil)
        self.selectScene = selectScene
        header.selectScene = selectScene
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
        header.layoutIfNeeded()
    }
}


extension SelectCategoryVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectScene.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryCell.identifier, 
                                                       for: indexPath) as? SelectCategoryCell else {
            fatalError("Unable deque cell...")
        }
        cell.category = selectScene.categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = SelectTagVC(
                selectScene: self.selectScene,
                selectCategory: self.selectScene.categories[indexPath.row]
            )
            self.present(vc, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SelectCategoryVC {
    
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
        table.register(SelectCategoryCell.self, forCellReuseIdentifier: SelectCategoryCell.identifier)
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
