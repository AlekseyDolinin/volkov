import UIKit

protocol SelectSceneVMDelegate: AnyObject {
    func updateContent()
    func tagsSendedSucces()
    func showFilteredPerformance()
}

class SelectSceneVM {
    
    weak var delegate: SelectSceneVMDelegate?
    
    var scenes = [Scene]()
    var performances = [Performance]()
    
    func parseData() {
        if let json = LocalStorage.shared.jsonData {
            for i in json["scenes"].arrayValue {
                let scene = Scene()
                scene.parse(json: i)
                scenes.append(scene)
                scenes.sort(by: { $0.name < $1.name })
            }
            delegate?.updateContent()
        }
    }
    
    func sendAllTags() {
        print(removeDoublesFromArray(arrayInt: LocalStorage.shared.savedIDsTags))
//        Task(priority: .userInitiated) {
//            let link = "https://mirteatr.vovlekay.online/api/save_session/"
//            let parameters = setParameters()
//            print("parameters: \(parameters)")
//            let json = await API.shared._request(link, method: .post, parameters: parameters)
//            if let json = json {
//                print(json)
                self.delegate?.tagsSendedSucces()
            LocalStorage.shared.idSession = 121212
//            }
//        }
    }
    
    private func checkFilteredPerformance() {
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/checkFilteredPerformance/"
            let parameters = setParameters()
            print("parameters: \(parameters)")
            let json = await API.shared._request(link, method: .post, parameters: parameters)
            if let json = json {
                print(json)
                for i in json.arrayValue {
                    print(i)
                    let performance = Performance()
                    performance.parse(json: i)
                    performances.append(performance)
                }
            }
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
        parameters["labels"] = removeDoublesFromArray(arrayInt: LocalStorage.shared.savedIDsTags)
        return parameters
    }
    
    private func removeDoublesFromArray(arrayInt: [Int]) -> [Int] {
        return Array(Set(arrayInt))
    }
}
