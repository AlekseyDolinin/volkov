import Foundation
import UIKit

public extension UIViewController {
        
    func showLoader() {
        let loader = Loader()
        view.addSubview(loader)
        view.isUserInteractionEnabled = false
        //
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideLoader() {
        view.subviews.forEach { v in
            if v is Loader {
                v.removeFromSuperview()
                view.isUserInteractionEnabled = true
            }
            if v is UIVisualEffectView {
                v.removeFromSuperview()
            }
        }
    }
}
