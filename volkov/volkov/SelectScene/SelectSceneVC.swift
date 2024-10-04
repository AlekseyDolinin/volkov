import UIKit

class SelectSceneVC: GeneralViewController {

    private var vm: SelectSceneVM!
    
    private var table = UITableView()
    private var header = HeaderSelectScene()
    
    private var bottomView = UIView()
    private let sendAllTagsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = SelectSceneVM()
        vm?.delegate = self
        vm?.parseData()
        createSubviews()
        header.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
        
        checkCompletedFinalScene()
    }
    
    override func back_() {
        let title = "Хотите начать с начала?"
        let message = "Все введенные данные и сохранённые метки будут удалены."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "Да, начать сначала", style: .default) { [weak self] _ in
            LocalStorage.shared.clearAllUD()
            if let viewControllers = self?.navigationController?.viewControllers {
                viewControllers.forEach { vc in
                    if vc is CreatePlayerVC {
                        vc.removeFromParent()
                    }
                }
            }
            self?.navigationController?.popViewController(animated: true)
        }
        let closeAlert = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(closeAlert)
        alert.addAction(backAction)
        present(alert, animated: true)
    }
    
    private func checkCompletedFinalScene() {
        if let finalScene = vm.scenes.first(where: { $0.isFinal == true }) {
            let savedTags = LocalStorage.shared.savedIDsTags
            var sceneTags: [Tag] = []
            let sceneСategories = finalScene.categories
            for i in sceneСategories {
                sceneTags += i.tags
            }
            let sceneIDsTags = sceneTags.map({ $0.id })
            let setSavedTags: Set<Int> = Set(savedTags)
            let setSceneIDsTags: Set<Int> = Set(sceneIDsTags)
            let intersection = setSavedTags.intersection(setSceneIDsTags)

            bottomView.isHidden = intersection.isEmpty
        }
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
                let vc = SelectTagVC(
                    selectScene: selectScene,
                    selectCategory: selectCategory
                )
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
    
    private func showAlertSendAllTags() {
        let title = "Отправить все выбраные метки?"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let sendAction = UIAlertAction(title: "Отправить", style: .default) { [weak self] _ in
            self?.sendTags()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(sendAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func sendTags() {
        LocalStorage.shared.finishSessionDate = Date()
        vm.sendAllTags()
    }
}


extension SelectSceneVC: SelectSceneVMDelegate {
    
    func updateContent() {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    func tagsSendedSucces() {
        DispatchQueue.main.async {
            self.showLoader()
        }
    }
    
    func showFilteredPerformance() {
        DispatchQueue.main.async {
            print("showListPerformance")
            self.hideLoader()
            let vc = ListPerformanceVC(performances: self.vm.performances)
            self.navigationController?.pushViewController(vc, animated: true)
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
        createBottomView()
        createSendAllTagsButton()
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
    
    private func createBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .black
        bottomView.isHidden = true
        //
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createSendAllTagsButton() {
        bottomView.addSubview(sendAllTagsButton)
        sendAllTagsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        sendAllTagsButton.layer.cornerRadius = 8
        sendAllTagsButton.setTitle("Отправить все метки", for: .normal)
        sendAllTagsButton.setTitleColor(.black, for: .normal)
        sendAllTagsButton.backgroundColor = gold
        let action = UIAction { [weak self] _ in
            self?.showAlertSendAllTags()
        }
        sendAllTagsButton.addAction(action, for: .touchUpInside)
        //
        sendAllTagsButton.translatesAutoresizingMaskIntoConstraints = false
        sendAllTagsButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 16).isActive = true
        sendAllTagsButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -16).isActive = true
        sendAllTagsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        sendAllTagsButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        sendAllTagsButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
