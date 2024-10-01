import UIKit

protocol SelectSceneVMDelegate: AnyObject {
    func updateContent()
}

class SelectSceneVM {
    
    weak var delegate: SelectSceneVMDelegate?
    
    var scenes = [Scene]()
    
    func parseData() {
        let json = LocalStorage.shared.jsonData
        
        for i in json["scenes"].arrayValue {
            let scene = Scene()
            scene.parse(json: i)
            scenes.append(scene)
        }
        delegate?.updateContent()
    }
}
