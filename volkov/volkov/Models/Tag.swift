import Foundation

class Tag {
    
    var id: Int = 0
    var name: String = ""
    var isSignificant: Bool = false
}

extension Tag {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        isSignificant = json["is_significant"].boolValue
    }
}
