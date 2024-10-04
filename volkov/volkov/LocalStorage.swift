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
    
    var startSessionString: String?
    var finishSessionString: String?
    
    var startSessionDate: Date? {
        didSet {
            print("didSet startSessionDate: \(startSessionDate)")
            if startSessionDate == nil {
                startSessionString = nil
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: startSessionDate ?? Date())
            print("dateString: \(dateString)")
            startSessionString = dateString
            UserDefaults.standard.setValue(dateString, forKey: "startSession")
        }
    }
    
    var finishSessionDate: Date? {
        didSet {
            if finishSessionDate == nil {
                finishSessionString = nil
                return
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: finishSessionDate ?? Date())
            finishSessionString = dateString
            UserDefaults.standard.setValue(dateString, forKey: "finishSession")
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
        startSessionDate = nil
        finishSessionDate = nil
        startSessionDate = nil
        finishSessionDate = nil
        
        idSession = nil
    }
    
    let categoryMultiSelect = ["choose_genre": 4, "voice_of_the_people": 7, "hero_values": 3, "pains_of_a_hero": 3]
}
