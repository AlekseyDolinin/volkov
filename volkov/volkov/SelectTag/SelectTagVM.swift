import Foundation

protocol SelectTagVMDelegate: AnyObject {
    func updateContent()
    func saveTagsSucces()
}

final class SelectTagVM {
    
    weak var delegate: SelectTagVMDelegate?
    
    var selectScene: Scene!
    var selectCategory: Category!
    
    func saveTags() {
        let selectedTags = selectCategory.tags.filter({ $0.isSelect == true })
        let selectedIDsTags = selectedTags.map({ $0.id })
        saveAction(arrayIDs: selectedIDsTags)
    }
    
    private func saveAction(arrayIDs: [Int]) {
        
        let arrayLaterSavedTags: [Int] = LocalStorage.shared.savedIDsTags ?? []
        print("arrayLaterSavedTags: \(arrayLaterSavedTags)")
        
        LocalStorage.shared.savedIDsTags = arrayLaterSavedTags + arrayIDs
        
        print("--------------------------------------")
        
        print("LocalStorage.shared.savedIDsTags: \(LocalStorage.shared.savedIDsTags)")
        print("in UD: \(UserDefaults.standard.object(forKey: "selectedIDsTags"))")
        
        
        
        
//        var arrayLaterSavedTags: [Int] = LocalStorage.shared.savedIDsTags as? [Int] ?? []
//        
//        print("arrayLaterSavedTags_1: \(arrayLaterSavedTags)")
//        print("arrayLaterSavedTags_2: \(arrayIDs)")
//        
//        arrayLaterSavedTags = arrayLaterSavedTags + arrayIDs
//        
//        print("arrayLaterSavedTags_3: \(arrayLaterSavedTags)")
//        
//        UserDefaults.standard.setValue(arrayLaterSavedTags, forKey: "selectedIDsTags")
//        
//        print("tags from UserDefaults: \(arrayLaterSavedTags)")
        
        
        delegate?.saveTagsSucces()
        
    }
}
