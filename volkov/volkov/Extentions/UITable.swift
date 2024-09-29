import Foundation
import UIKit

public extension UITableView {
    
    func createClearFooter(height: CGFloat = 120) {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: height))
    }
    
}
