import UIKit

class SelectAssistentVC: UIViewController {

    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let titlePrimery = UILabel()
    private let stack = UIStackView()
    
    private var assistants = [Assistant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = .black
        createSubviews()
        parseAssistents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDontCompletedSession()
    }
    
    private func checkDontCompletedSession() {
        print("idSelectAssistent: \(LocalStorage.shared.idSelectAssistent)")
        print("namePlayer: \(LocalStorage.shared.namePlayer)")
        
        // есть незаконченая сессия
        if LocalStorage.shared.idSelectAssistent != nil && LocalStorage.shared.namePlayer != nil {
            getAssistent()
        }
    }
    
    private func getAssistent() {
        if let idAssistent = LocalStorage.shared.idSelectAssistent {
            if let idAssistentInt = Int(idAssistent) {
                let assistant = assistants.filter({ $0.id == idAssistentInt })
                if let ass = assistant.first, let namePlayer = LocalStorage.shared.namePlayer {
                    let nameAssistent = "\(ass.surname) \(ass.name) \(ass.middleName)"
                    showDontCompletedSession(nameAssistent: nameAssistent, namePlayer: namePlayer)
                }
            }
        }
    }
        
    private func showDontCompletedSession(nameAssistent: String, namePlayer: String) {
        let title = "Игра не была завершена"
        let message = "Помошник: \(nameAssistent) \nИгрок: \(namePlayer)"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let continueAction = UIAlertAction(title: "Продолжить", style: .default) { [weak self] _ in
            let vc = SelectSceneVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        let newStartAction = UIAlertAction(title: "Начать заново", style: .default) { [weak self] _ in
            self?.clearAllUD()
        }
        alert.addAction(continueAction)
        alert.addAction(newStartAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    private func clearAllUD() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    private func parseAssistents() {
        let json = LocalStorage.shared.jsonData
        for i in json["assistant"].arrayValue {
            let assistant = Assistant()
            assistant.parse(json: i)
            assistants.append(assistant)
        }
        createButtonsSelectAssistent()
    }
    
    private func createButtonsSelectAssistent() {
        for i in 0..<assistants.count {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            button.layer.cornerRadius = 16
            let title = "\(assistants[i].surname) \(assistants[i].name) \(assistants[i].middleName)"
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = gold
            button.tag = i
            let actionSelect = UIAction { [weak self] _ in
                self?.selectAssistent(btn: button)
            }
            button.addAction(actionSelect, for: .touchUpInside)
            //
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            stack.addArrangedSubview(button)
        }
    }
    
    private func selectAssistent(btn: UIButton) {
        LocalStorage.shared.selectAssistent = assistants[btn.tag]
        UserDefaults.standard.setValue(assistants[btn.tag].id, forKey: "idSelectAssistent")
        //
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1) {
                btn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                btn.transform = .identity
                let vc = CreatePlayerVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension SelectAssistentVC {
    
    private func createSubviews() {
        createScroll()
        createViewBack()
        createTitle()
        createStack()
    }
    
    private func createScroll() {
        view.addSubview(scroll)
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        //
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createViewBack() {
        scroll.addSubview(viewBack)
        viewBack.backgroundColor = .clear
        //
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        viewBack.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        viewBack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewBack.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        viewBack.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
    }
    
    private func createTitle() {
        viewBack.addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titlePrimery.text = "Выберите помощника"
        titlePrimery.textAlignment = .center
        titlePrimery.numberOfLines = 0
        titlePrimery.textColor = .white
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        titlePrimery.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 48).isActive = true
    }
    
    private func createStack() {
        viewBack.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 16
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: titlePrimery.bottomAnchor, constant: 40).isActive = true
        stack.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
}
