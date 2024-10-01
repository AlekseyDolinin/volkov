import Foundation

class Scene {
    
    var id: Int = 0
    var name: String = ""
    var isFinal: Bool = false
    var categories: [Category] = []
    var isSignificant: Bool = false
}

extension Scene {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        isFinal = json["is_final"].boolValue
        isSignificant = json["is_significant"].boolValue
        //
        setCategories(json: json["categories"])
    }
    
    private func setCategories(json: JSON) {
        self.categories.removeAll()
        for i in json.arrayValue {
            let category = Category()
            category.parse(json: i)
            self.categories.append(category)
        }
    }
}
