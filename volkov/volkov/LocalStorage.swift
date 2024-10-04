import UIKit

class LocalStorage: NSObject {

    static let shared = LocalStorage()
    
    var assistents: [Assistant]! = []
    
    var jsonData: JSON! {
        didSet {
            if let jsonString = jsonData.rawString() {
                UserDefaults.standard.setValue(jsonString, forKey: "data")
            }
        }
    }
    
    var idSession: Int? {
        didSet {
            UserDefaults.standard.setValue(idSession, forKey: "idSession")
        }
    }
    
    var namePlayer: String? {
        didSet {
            UserDefaults.standard.setValue(namePlayer, forKey: "namePlayer")
        }
    }
    
    var idSelectAssistent: Int? {
        didSet {
            UserDefaults.standard.setValue(idSelectAssistent, forKey: "idSelectAssistent")
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
    
    var savedIDsTags: [Int] = [] {
        didSet {
            UserDefaults.standard.setValue(savedIDsTags, forKey: "selectedIDsTags")
        }
    }
    
    
    func clearAllUD() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        savedIDsTags.removeAll()
        namePlayer = nil
        idSelectAssistent = nil
        startSession = nil
        finishSession = nil
        idSession = nil
    }
    
    let categoryMultiSelect = ["choose_genre": 4, "voice_of_the_people": 7, "hero_values": 3, "pains_of_a_hero": 3]
}
