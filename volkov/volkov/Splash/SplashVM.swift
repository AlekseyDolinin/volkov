import UIKit

protocol SplashVMDelegate: AnyObject {
    func offlineMode()
    func updateContent()
}

class SplashVM {
    
    weak var delegate: SplashVMDelegate?
    
    func getData() {
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/game_data/"
            let json = await API.shared._request(link)
            if json == nil && getJSON("data") != nil {
                delegate?.offlineMode()
                LocalStorage.shared.jsonData = getJSON("data") ?? JSON()
            }
            if let json = json {
                delegate?.updateContent()
                saveJSON(json: json, key: "data")
                LocalStorage.shared.jsonData = json
                delegate?.updateContent()
            }
        }
    }
    
    private func saveJSON(json: JSON, key: String){
        if let jsonString = json.rawString() {
            UserDefaults.standard.setValue(jsonString, forKey: key)
        }
    }
    
    private func getJSON(_ key: String) -> JSON? {
        var p = ""
        if let result = UserDefaults.standard.string(forKey: key) {
            p = result
        }
        if p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    return try JSON(data: json)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
