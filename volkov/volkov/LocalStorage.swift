import UIKit

class LocalStorage: NSObject {

    static let shared = LocalStorage()
    var jsonData = JSON()
    var selectAssistent: Assistant!
    
    var idSelectAssistent = UserDefaults.standard.string(forKey: "idSelectAssistent")
    var namePlayer = UserDefaults.standard.string(forKey: "namePlayer")
    var startSession = UserDefaults.standard.string(forKey: "startSession")
    var finishSession = UserDefaults.standard.string(forKey: "finishSession")
//    var savedIDsTags = UserDefaults.standard.object(forKey: "selectedIDsTags")
    
    
    var savedIDsTags: [Int]? {
        didSet {
            UserDefaults.standard.setValue(savedIDsTags, forKey: "selectedIDsTags")
        }
    }
}
