import UIKit

class ListPerformanceVC: GeneralViewController {
    
    private var table = UITableView()
    private var header = HeaderListPerformance()
    
    private var performances = [Performance]()
        
    init(performances: [Performance]) {
        super.init(nibName: nil, bundle: nil)
        self.performances = performances
        print("performances1: \(performances)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        header.layoutIfNeeded()
        infoButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
}


extension ListPerformanceVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return performances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PerformanceCell.identifier, 
                                                       for: indexPath) as? PerformanceCell else {
            fatalError("Unable deque cell...")
        }
        cell.performance = performances[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = PerformanceDetailVC(performance: self.performances[indexPath.row])
            self.present(vc, animated: true)
        }
    }
}


extension ListPerformanceVC {
    
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
        table.register(PerformanceCell.self, forCellReuseIdentifier: PerformanceCell.identifier)
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
