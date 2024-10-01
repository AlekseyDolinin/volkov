import UIKit

class GeneralViewController: UIViewController {
        
    private let backButton = UIButton(type: .custom)
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .black
        createBackButton()
    }
    
    private func createBackButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let imageArrow = UIImage(systemName: "arrow.backward", withConfiguration: configuration)
        backButton.setImage(imageArrow, for: .normal)
        backButton.tintColor = gold
        backButton.addTarget(self, action: #selector(back_), for: .touchUpInside)
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc 
    func back_() {
        navigationController?.popViewController(animated: true)
    }
}
