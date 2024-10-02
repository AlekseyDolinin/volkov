import UIKit

class GeneralViewController: UIViewController {
        
    private let backButton = UIButton(type: .custom)
    private let infoButton = UIButton(type: .custom)
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        createBackButton()
        createInfoButton()
    }
    
    private func createBackButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let imageArrow = UIImage(systemName: "arrow.backward", withConfiguration: configuration)
        backButton.setImage(imageArrow, for: .normal)
        backButton.tintColor = gold
        backButton.addTarget(self, action: #selector(back_), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func createInfoButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let imageArrow = UIImage(systemName: "info.circle", withConfiguration: configuration)
        infoButton.setImage(imageArrow, for: .normal)
        infoButton.tintColor = gold
        infoButton.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        //
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    @objc 
    func back_() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func showInfo() {
        let assistentsFiltered = LocalStorage.shared.assistents.filter({ $0.id == LocalStorage.shared.idSelectAssistent })
        if let assistent = assistentsFiltered.first {
            let surname = assistent.surname
            let name = assistent.name
            let middleName = assistent.middleName
            let assistentName = "\(surname) \(name) \(middleName)"
            //
            var title = ""
            if LocalStorage.shared.namePlayer == nil {
                title = "Помощник: \(assistent.name)"
            } else {
                title = "Помощник: \(assistentName)\nИгрок: \(LocalStorage.shared.namePlayer!)"
            }
            let alert = UIAlertController(
                title: title,
                message: nil,
                preferredStyle: .alert
            )
            let notInternetAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(notInternetAction)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }

    }
}
