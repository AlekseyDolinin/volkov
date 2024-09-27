import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemPink
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showSelectAssistentVC()
        }
    }

    private func showSelectAssistentVC() {
        print("showSelectAssistentVC")
        DispatchQueue.main.async {
            let vc = SelectAssistentVC()
            print(self.navigationController)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

