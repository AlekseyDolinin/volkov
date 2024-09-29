import Foundation

protocol SelectMarkVMDelegate: AnyObject {
    func updateContent()
    func saveMarkSucces()
}

final class SelectMarkVM {
    
    weak var delegate: SelectMarkVMDelegate?
    
    var typeSelectMark: TypeSelectMark!
    var markIDs: [Int] = []
        
    func getData() {

    }
    
    func saveMarks() {
        delegate?.saveMarkSucces()
    }
    
}
