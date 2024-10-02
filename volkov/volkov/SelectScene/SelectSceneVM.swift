import UIKit

protocol SelectSceneVMDelegate: AnyObject {
    func updateContent()
    func tagsSended()
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
            scenes.sort(by: { $0.name < $1.name })
        }
        delegate?.updateContent()
    }
    
    func sendAllTags() {
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/save_session/"
            let parameters = setParameters()
            print("parameters: \(parameters)")
//            let json = await API.shared._request(link, method: .post, parameters: parameters)
//            if let json = json {
//                print(json)
//                self.delegate?.tagsSended()
//            }
        }
    }
    
    private func setParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["assistant_id"] = LocalStorage.shared.idSelectAssistent ?? 0
        parameters["player"] = ["name": LocalStorage.shared.namePlayer,
                                "surname": " ",
                                "middle_name": " "]
        parameters["start_date"] = LocalStorage.shared.startSession
        parameters["finish_date"] = LocalStorage.shared.finishSession
        parameters["labels"] = removeDoublesFromArray(arrayInt: LocalStorage.shared.savedIDsTags ?? [])
        return parameters
    }
    
    private func removeDoublesFromArray(arrayInt: [Int]) -> [Int] {
        return Array(Set(arrayInt))
    }
}
