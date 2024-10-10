import UIKit

class SelectAssistentVC: GeneralViewController {

    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let titlePrimery = UILabel()
    private let stack = UIStackView()
        
    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = .black
        parseAssistents()
        createSubviews()
        checkDontCompletedSession()
        backButton.isHidden = true
        infoButton.isHidden = true
    }
    
    private func checkDontCompletedSession() {
        // есть незаконченая сессия
        let idSelectAssistent = UserDefaults.standard.string(forKey: "idSelectAssistent")
        let namePlayer = UserDefaults.standard.string(forKey: "namePlayer")
        if idSelectAssistent != nil && namePlayer != nil {
            print("есть незаконченая сессия")
            showDontCompletedSession()
        }
    }
        
    private func showDontCompletedSession() {
        let title = "Игра не была завершена"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let continueAction = UIAlertAction(title: "Продолжить", style: .default) { [weak self] _ in
            let vc = SelectSceneVC()
            self?.navigationController?.pushViewController(vc, animated: true)
            self?.readUD()
        }
        let newStartAction = UIAlertAction(title: "Начать заново", style: .default) { _ in
            LocalStorage.shared.clearAllUD()
        }
        alert.addAction(continueAction)
        alert.addAction(newStartAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    // востановление меток из UserDefaults
    private func readUD() {
        print("востановление из UserDefaults")
        
        // ids tags
        if let ids = UserDefaults.standard.object(forKey: "selectedIDsTags") {
            if let arrayIDsInt: [Int] = ids as? [Int] {
                LocalStorage.shared.savedIDsTags = arrayIDsInt
            }
        }
        
        // namePlayer
        let namePlayer = UserDefaults.standard.string(forKey: "namePlayer")
        if let name = namePlayer {
            LocalStorage.shared.namePlayer = name
        }
        
        // idSelectAssistent
        let idSelectAssistent = UserDefaults.standard.integer(forKey: "idSelectAssistent")
        LocalStorage.shared.idSelectAssistent = idSelectAssistent
        
        // idSession
        let idSession = UserDefaults.standard.integer(forKey: "idSession")
        LocalStorage.shared.idSession = idSession
        
        // start sesion Date
        let startSessionDate = UserDefaults.standard.string(forKey: "startSession")
        LocalStorage.shared.startSessionString = startSessionDate
        
        // finish sesion Date
        let finishSessionString = UserDefaults.standard.string(forKey: "finishSession")
        LocalStorage.shared.finishSessionString = finishSessionString
    }
    
    private func parseAssistents() {
        print("parseAssistents")
        if let json = LocalStorage.shared.jsonData {
            for i in json["assistants"].arrayValue {
                let assistant = Assistant()
                assistant.parse(json: i)
                if LocalStorage.shared.assistents.map({$0.id}).contains(assistant.id) { return }
                LocalStorage.shared.assistents.append(assistant)
            }
            createButtonsSelectAssistent()
        }
    }
    
    private func createButtonsSelectAssistent() {
        stack.subviews.forEach { v in
            v.removeFromSuperview()
        }
        for i in 0..<LocalStorage.shared.assistents.count {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            let surname = LocalStorage.shared.assistents[i].surname
            let name = LocalStorage.shared.assistents[i].name
            let middleName = LocalStorage.shared.assistents[i].middleName
            button.layer.cornerRadius = 16
            let title = "\(surname) \(name) \(middleName)"
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
        LocalStorage.shared.idSelectAssistent = LocalStorage.shared.assistents[btn.tag].id
        //
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1) {
                btn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                btn.transform = .identity
                let vc = CreatePlayerVC(nc: self.navigationController)
                self.present(vc, animated: true)
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
