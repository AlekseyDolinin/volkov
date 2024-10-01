import Foundation

protocol SelectTagVMDelegate: AnyObject {
    func updateContent()
    func saveTagsSucces()
}

final class SelectTagVM {
    
    weak var delegate: SelectTagVMDelegate?
    
    var selectScene: Scene!
    var selectCategory: Category!
    var tagIDs: [Int] = []
    
    func saveTags() {
        let codeCategory = selectCategory.code
        UserDefaults.standard.set(tagIDs, forKey: codeCategory)
        delegate?.saveTagsSucces()
    }
    
}
