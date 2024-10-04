import Foundation

class Performance {
    
    var id: Int = 0
    var name: String = ""
}

extension Performance {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
