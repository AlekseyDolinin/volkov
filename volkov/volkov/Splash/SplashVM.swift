import UIKit

protocol SplashVMDelegate: AnyObject {
    func updateContent()
}

class SplashVM {
    
    weak var delegate: SplashVMDelegate?
    
    func getData() {
        Task(priority: .userInitiated) {
            let link = "https://volkov.vovlekay.online/api/game_data/"
            let json = await API.shared._request(link)
            if let json = json {
                print("json: \(json)")
//                await tower.parseTower(json: json)
            }
            delegate?.updateContent()
        }
    }
}
