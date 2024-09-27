import UIKit

class SplashVC: UIViewController {
    
    private var vm: SplashVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemPink
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showSelectAssistentVC()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm = SplashVM()
        vm?.delegate = self
        vm?.getData()
    }

    private func showSelectAssistentVC() {
        print("showSelectAssistentVC")
        DispatchQueue.main.async {
            let vc = SelectAssistentVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension SplashVC: SplashVMDelegate {
    
    func updateContent() {
        print("updateContent")
    }
}
