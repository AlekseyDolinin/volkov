import UIKit

class SelectAssistentVC: UIViewController {

    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let titlePrimery = UILabel()
    private let stack = UIStackView()

    let listAssistent = ["Ivanov Ivay", "Petrov Petr", "Kuznetsov Kuzya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        createSubviews()
        createButtonsSelectAssistent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func createButtonsSelectAssistent() {
        for i in 0..<listAssistent.count {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .light)
            button.layer.cornerRadius = 16
            button.setTitle(listAssistent[i], for: .normal)
            button.backgroundColor = darkBlue
            button.tag = i
            let action = UIAction { [weak self] _ in
                self?.selectAssistent(index: button.tag)
            }
            button.addAction(action, for: .touchUpInside)
            //
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            stack.addArrangedSubview(button)
        }
    }
    
    private func selectAssistent(index: Int) {
        DispatchQueue.main.async {
            let vc = CreatePlayerVC(nameAssistent: self.listAssistent[index])
            self.navigationController?.pushViewController(vc, animated: true)
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
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .light)
        titlePrimery.text = "Выберите помощника"
        titlePrimery.textAlignment = .center
        titlePrimery.numberOfLines = 0
        titlePrimery.textColor = darkBlue
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

