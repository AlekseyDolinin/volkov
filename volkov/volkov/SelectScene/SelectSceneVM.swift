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
    
    func pickAction() {
        print("pickAction")
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/save_session/"
            let json = await API.shared._request(link, parameters: setParameters())
            if let json = json {
                print(json)
                
            }
        }
    }
    
//    {
//        "assistant_id": 1,
//        "player": {
//            "name": "John",
//            "surname": "Snow",
//            "middle_name": "Иванович"
//        },
//            "start_date": "2024-09-30 09:00:01.880615+03",
//            "finish_date": "2024-09-30 10:00:01.880615+03",
//            "labels": [1, 4, 5, 6, 7, 20, 25]
//    }
    private func setParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["assistant_id"] = LocalStorage.shared.idSelectAssistent
        parameters["player"] = ["name": LocalStorage.shared.namePlayer,
                                "surname": "",
                                "middle_name": ""]
        parameters["labels"] = []
        parameters["start_date"] = LocalStorage.shared.startSession
        parameters["finish_date"] = LocalStorage.shared.finishSession
        return parameters
    }
}
