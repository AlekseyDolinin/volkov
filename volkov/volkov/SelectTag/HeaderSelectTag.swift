import UIKit

class HeaderSelectTag: UIView {
    
    private let titlePrimery = UILabel()
    
    var selectScene: Scene!
    var selectCategory: Category!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setView() {
//        switch typeSelectMark {
//        case .multi:
//            titlePrimery.text = "Выберите несколько меток"
//        case .single:
//            titlePrimery.text = "Выберите одну метку"
//        default:
//            titlePrimery.text = "Выберите метку"
//        }
        titlePrimery.text = "Выберите метку"
        layoutIfNeeded()
    }
}


extension HeaderSelectTag {
    
    private func createSubViews() {
        createTitle()
    }
    
    private func createTitle() {
        addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 32, weight: .light)
        titlePrimery.textColor = .white
        titlePrimery.lineBreakMode = .byWordWrapping
        titlePrimery.numberOfLines = 0
        titlePrimery.textAlignment = .center
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titlePrimery.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
