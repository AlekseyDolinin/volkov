import Foundation

class Assistant {
    
    var id: Int = 0
    var name: String = ""
    var middleName: String = ""
    var surname: String = ""
}

extension Assistant {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        middleName = json["middle_name"].stringValue
        surname = json["surname"].stringValue
    }
}
