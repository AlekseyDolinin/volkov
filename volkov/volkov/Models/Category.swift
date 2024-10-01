import Foundation

class Category {
    
    var id: Int = 0
    var name: String = ""
    var code: String = ""
    var tags: [Tag] = []
    var isSignificant: Bool = false
}

extension Category {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        code = json["code"].stringValue
        isSignificant = json["is_significant"].boolValue
        //
        setTags(json: json["labels"])
    }
    
    private func setTags(json: JSON) {
        self.tags.removeAll()
        for i in json.arrayValue {
            let tag = Tag()
            tag.parse(json: i)
            self.tags.append(tag)
        }
    }
}
