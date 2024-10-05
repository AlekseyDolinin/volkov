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
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/save_session/"
            let parameters = setParameters()
            print("parameters: \(parameters)")
            let json = await API.shared._request(link, method: .post, parameters: parameters)
            if let json = json {
                self.delegate?.tagsSendedSucces()
                let idSession = json["session_id"].intValue
                LocalStorage.shared.idSession = idSession
                checkFilteredPerformance(idSession: idSession)
            }
        }
    }
    
    private func checkFilteredPerformance(idSession: Int) {
        Task(priority: .userInitiated) {
            let link = "https://mirteatr.vovlekay.online/api/session/\(idSession)/performances/"
            let json = await API.shared._request(link)
            if let json = json {
                performances.removeAll()
                for i in json.arrayValue {
                    let performance = Performance()
                    performance.parse(json: i)
                    performances.append(performance)
                }
                delegate?.showFilteredPerformance()
            }
        }
    }
    
    private func setParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["assistant_id"] = LocalStorage.shared.idSelectAssistent ?? 0
        parameters["player"] = ["name": LocalStorage.shared.namePlayer,
                                "surname": " ",
                                "middle_name": " "]
        parameters["start_date"] = LocalStorage.shared.startSessionString
        parameters["finish_date"] = LocalStorage.shared.finishSessionString
        parameters["labels"] = removeDoublesFromArray(arrayInt: LocalStorage.shared.savedIDsTags)
        print(LocalStorage.shared.savedIDsTags.sorted(by: { $0 < $1 }))
        return parameters
    }
    
    private func removeDoublesFromArray(arrayInt: [Int]) -> [Int] {
        return Array(Set(arrayInt))
    }
}
