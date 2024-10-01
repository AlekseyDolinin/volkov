import UIKit

class LocalStorage: NSObject {

    static let shared = LocalStorage()
    var jsonData = JSON()
    
    
    var selectAssistent: Assistant!
    
    var idSelectAssistent = UserDefaults.standard.string(forKey: "idSelectAssistent")
    var namePlayer = UserDefaults.standard.string(forKey: "namePlayer")
    
    
}
