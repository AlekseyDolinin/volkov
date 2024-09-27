import UIKit

class GeneralViewController: UIViewController {
        
    private let backButton = UIButton(type: .custom)
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        setNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        setNavigationBar()
    }
        
    private func setNavigationBar() {
        createBackButton()
    }
    
    private func createBackButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        let imageArrow = UIImage(systemName: "arrow.backward", withConfiguration: configuration)
        backButton.setImage(imageArrow, for: .normal)
        backButton.tintColor = darkBlue
        backButton.addTarget(self, action: #selector(back_), for: .touchUpInside)
        //
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func back_() {
        navigationController?.popViewController(animated: true)
    }
}


extension GeneralViewController: UIGestureRecognizerDelegate {
    
    // не обрабатывать свайп назад если нахожусь на первом экране или в на экране боя
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}
