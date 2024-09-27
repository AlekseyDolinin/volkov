import UIKit

class SelectAssistentVC: UIViewController {

    private let stack = UIStackView()

    let listAssistent = ["Ivanov Ivay", "Petrov Petr", "Kuznetsov Kuzya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .purple
        createSubviews()
    }

    private func createButtonsSelectAssistent() {
        for i in 0..<listAssistent.count {
            let button = UIButton()
            button.setTitle(listAssistent[i], for: .normal)
            //
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            stack.addArrangedSubview(button)
        }
    }

}

extension SelectAssistentVC {
    
    private func createSubviews() {
        createStack()
    }
    
    private func createStack() {
        view.addSubview(stack)
        stack.axis = .vertical
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
}

