import UIKit

class SplashVC: UIViewController {
    
    private var vm: SplashVM?
    
    private let logoTheater = UIImageView()
    private let logoLabmedia = UIImageView()
    private let loader = UIActivityIndicatorView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = SplashVM()
        vm?.delegate = self
        createSubviews()
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.vm?.getData()
        }
    }

    private func showSelectAssistentVC() {
        DispatchQueue.main.async {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.black
            ]
            navigationBarAppearance.backgroundColor = UIColor.black
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
    
    private func showAlertOfflineMode() {
        let title = "Отсутствует соединение с интернет"
        let message = "Будут использоваться ранее сохраненные данные"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let notInternetAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.showSelectAssistentVC()
        }
        alert.addAction(notInternetAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}


extension SplashVC: SplashVMDelegate {
    
    func offlineMode() {
        showAlertOfflineMode()
    }
    
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
        logoTheater.image = UIImage(named: "logoT")
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
        logoLabmedia.image = UIImage(named: "logoBB_white")
        logoLabmedia.contentMode = .scaleAspectFit
        logoLabmedia.alpha = 0.7
        //
        logoLabmedia.translatesAutoresizingMaskIntoConstraints = false
        logoLabmedia.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabmedia.heightAnchor.constraint(equalToConstant: 60).isActive  = true
        logoLabmedia.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    private func createLoader() {
        view.addSubview(loader)
        loader.style = .medium
        loader.color = .white
        loader.startAnimating()
        //
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.bottomAnchor.constraint(equalTo: logoLabmedia.topAnchor, constant: -24).isActive = true
    }
}
