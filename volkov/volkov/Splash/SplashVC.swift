import UIKit

class SplashVC: UIViewController {
    
    private var vm: SplashVM?
    
    private let logoTheater = UIImageView()
    private let logoLabmedia = UIImageView()
    private let loader = UIActivityIndicatorView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm = SplashVM()
        vm?.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.vm?.getData()
        }
    }

    private func showSelectAssistentVC() {
        DispatchQueue.main.async {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.white
            navigationBarAppearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            let nc = UINavigationController()

            nc.addChild(SelectAssistentVC())
            SceneDelegate.window?.rootViewController = nc
            SceneDelegate.window?.makeKeyAndVisible()
        }
    }
}


extension SplashVC: SplashVMDelegate {
    
    func updateContent() {
        showSelectAssistentVC()
    }
}


extension SplashVC {
    
    private func createSubviews() {
        createLogoTheater()
        createLogoLabmedia()
        createLoader()
    }
    
    private func createLogoTheater() {
        view.addSubview(logoTheater)
        logoTheater.image = UIImage(named: "logo")
        logoTheater.contentMode = .scaleAspectFit
        //
        logoTheater.translatesAutoresizingMaskIntoConstraints = false
        logoTheater.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoTheater.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoTheater.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        logoTheater.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    private func createLogoLabmedia() {
        view.addSubview(logoLabmedia)
        logoLabmedia.image = UIImage(named: "labmedia_logo")
        logoLabmedia.contentMode = .scaleAspectFit
        //
        logoLabmedia.translatesAutoresizingMaskIntoConstraints = false
        logoLabmedia.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabmedia.heightAnchor.constraint(equalToConstant: 80).isActive  = true
        logoLabmedia.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    private func createLoader() {
        view.addSubview(loader)
        loader.style = .medium
        loader.color = darkBlue
        loader.startAnimating()
        //
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: logoLabmedia.topAnchor, constant: -24).isActive = true
    }
}
