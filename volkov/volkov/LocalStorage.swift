import UIKit

class LocalStorage: NSObject {

    static let shared = LocalStorage()
    var jsonData = JSON()
    
    var assistents: [Assistant]! = []
    
    var namePlayer: String? {
        didSet {
            UserDefaults.standard.string(forKey: "namePlayer")
        }
    }
    
    var idSelectAssistent: Int? {
        didSet {
            UserDefaults.standard.string(forKey: "idSelectAssistent")
        }
    }
    
    var startSession: String? {
        didSet {
            UserDefaults.standard.setValue(startSession, forKey: "startSession")
        }
    }
    
    var finishSession: String? {
        didSet {
            UserDefaults.standard.setValue(finishSession, forKey: "finishSession")
        }
    }
    
    var savedIDsTags: [Int]? {
        didSet {
            UserDefaults.standard.setValue(savedIDsTags, forKey: "selectedIDsTags")
        }
    }
}
