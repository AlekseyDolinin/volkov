import Foundation

class Performance {
    
    var id = 0
    var name = ""
    var image = ""
    var description = ""
    var playwright = ""
    var city = ""
    var theater = ""
    var year = ""
    var director = ""
    var hasFiveYearTour = false
    var hasTenYearRepertory = false
    var isInternational = false
    var hasReward = false
    var hasTVscreenVersion = false
    var notSelectedSabels = [Tag]()
}

extension Performance {
    
    func parse(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        image = json["image"].stringValue
        description = json["description"].stringValue
        playwright = json["playwright"].stringValue
        city = json["city"].stringValue
        theater = json["theater"].stringValue
        year = json["year"].stringValue
        director = json["director"].stringValue
        hasFiveYearTour = json["has_five_year_tour"].boolValue
        hasTenYearRepertory = json["has_ten_year_repertory"].boolValue
        isInternational = json["is_international"].boolValue
        hasReward = json["has_reward"].boolValue
        hasTVscreenVersion = json["has_tv_screen_version"].boolValue
        notSelectedSabels = parseTags(json: json["not_selected_labels"])
    }
    
    private func parseTags(json: JSON) -> [Tag] {
        var tags = [Tag]()
        for i in json.arrayValue {
            let tag = Tag()
            tag.parse(json: i)
            tags.append(tag)
        }
        return tags
    }
}
