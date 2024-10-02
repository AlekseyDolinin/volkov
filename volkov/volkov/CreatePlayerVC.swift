import UIKit

class CreatePlayerVC: GeneralViewController {

    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let nameAssistentLabel = UILabel()
    private let titlePrimery = UILabel()
    private let inputeNamePlayer = UITextField()
    private let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputeNamePlayer.text = ""
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.inputeNamePlayer.becomeFirstResponder()
        }
        if LocalStorage.shared.namePlayer != nil {
            inputeNamePlayer.text = LocalStorage.shared.namePlayer
            //
            startButton.alpha = inputeNamePlayer.text!.isEmpty ? 0.2 : 1.0
            startButton.isEnabled = !(inputeNamePlayer.text!.isEmpty)
        }
    }
    
    override func back_() {
        let title = "Хотите начать с начала?"
        let message = "Все введенные данные и сохранённые метки будут удалены."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backAction = UIAlertAction(title: "Да, начать сначала", style: .default) { [weak self] _ in
            self?.startOver()
        }
        let closeAlert = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(closeAlert)
        alert.addAction(backAction)
        present(alert, animated: true)
    }
    
    private func startOver() {
        LocalStorage.shared.clearAllUD()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editingChangedInput() {
        LocalStorage.shared.namePlayer = inputeNamePlayer.text
        //
        startButton.alpha = inputeNamePlayer.text!.isEmpty ? 0.2 : 1.0
        startButton.isEnabled = !(inputeNamePlayer.text!.isEmpty)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.startButton.transform = CGAffineTransform(translationX: 0, y: -(keyboardSize.height))
                }
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.startButton.transform = .identity
            }
        }
    }
    
    private func startAction() {
        DispatchQueue.main.async {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: Date())
            LocalStorage.shared.startSession = dateString
            //
            self.view.endEditing(true)
            let vc = SelectSceneVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CreatePlayerVC {
    
    private func createSubviews() {
        createScroll()
        createViewBack()
        createNameAssistent()
        createTitle()
        createInputeNameplayer()
        createInputeStartButton()
    }
    
    private func createScroll() {
        view.addSubview(scroll)
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        scroll.backgroundColor = .clear
        //
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
    
    private func createNameAssistent() {
        viewBack.addSubview(nameAssistentLabel)
        nameAssistentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameAssistentLabel.textAlignment = .center
        nameAssistentLabel.numberOfLines = 0
        nameAssistentLabel.textColor = .white.withAlphaComponent(0.7)
        //
        nameAssistentLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAssistentLabel.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        nameAssistentLabel.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        nameAssistentLabel.topAnchor.constraint(equalTo: viewBack.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        //
        let assistentsFiltered = LocalStorage.shared.assistents.filter({ $0.id == LocalStorage.shared.idSelectAssistent })
        if let assistent = assistentsFiltered.first {
            nameAssistentLabel.text = "\(assistent.surname) \(assistent.name) \(assistent.middleName)"
        }
    }
    
    private func createTitle() {
        viewBack.addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .light)
        titlePrimery.text = "Введите имя игрока"
        titlePrimery.textAlignment = .center
        titlePrimery.numberOfLines = 0
        titlePrimery.textColor = .white
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        titlePrimery.topAnchor.constraint(equalTo: nameAssistentLabel.bottomAnchor, constant: 48).isActive = true
    }
    
    private func createInputeNameplayer() {
        viewBack.addSubview(inputeNamePlayer)
        inputeNamePlayer.spellCheckingType = .no
        inputeNamePlayer.autocorrectionType = .no
        inputeNamePlayer.contentVerticalAlignment = .center
        inputeNamePlayer.textAlignment = .center
        inputeNamePlayer.font = UIFont.systemFont(ofSize: 18, weight: .light)
        inputeNamePlayer.textColor = .white
        inputeNamePlayer.tintColor = .white
        inputeNamePlayer.backgroundColor = .white.withAlphaComponent(0.1)
        inputeNamePlayer.layer.cornerRadius = 8
        inputeNamePlayer.addTarget(self, action: #selector(editingChangedInput), for: .editingChanged)
        //
        inputeNamePlayer.translatesAutoresizingMaskIntoConstraints = false
        inputeNamePlayer.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        inputeNamePlayer.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        inputeNamePlayer.topAnchor.constraint(equalTo: titlePrimery.bottomAnchor, constant: 24).isActive = true
        inputeNamePlayer.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -40).isActive = true
        inputeNamePlayer.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    private func createInputeStartButton() {
        view.addSubview(startButton)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        startButton.layer.cornerRadius = 8
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = gold
        startButton.alpha = 0.2
        startButton.isEnabled = false
        let action = UIAction { [weak self] _ in
            self?.startAction()
        }
        startButton.addAction(action, for: .touchUpInside)
        //
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}


extension CreatePlayerVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
