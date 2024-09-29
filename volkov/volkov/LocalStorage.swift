import UIKit

class LocalStorage: NSObject {

    static let shared = LocalStorage()
    
    let listAssistent = ["Ivanov Ivay", "Petrov Petr", "Kuznetsov Kuzya"]
    var nameAssistent = ""
    var namePlayer = ""
    let listScenes = ["Мужики решают проблемы",
                      "Несовершенство мира",
                      "Любовь побеждает смерть",
                      "Тяжелая женская доля",
                      "Война ужасна",
                      "Путь к счастливой жизни",
                      "Победа человека над…",
                      "Побег от реальности",
                      "Мир прекрасен",
                      "потерянное поколение",
                      "Конфликт отцов и детей",
                      "поиск бога/поиск себя",
                      "Маленький человек",
                      "Пороки общества",
                      "Семейные корни",
                      "Честь превыше всего",
                      "Насилие рождает насилие",
                      "Бесцельность бытия"]
    
    let listPerformances = ["«Много шума из ничего»",
                            "Ромео и Джульетта",
                            "Три сестры", 
                            "Вишнёвый сад",
                            "Сирано де Бержерак", 
                            "Мамаша Кураж и её дети",
                            "Лейтенант с острова Инишмор"]
    
    
    
    var marks = [["name": "mark_1", "select": false],
                 ["name": "mark_2", "select": false],
                 ["name": "mark_3", "select": false],
                 ["name": "mark_4", "select": false],
                 ["name": "mark_5", "select": false]]
}
