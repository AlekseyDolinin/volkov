import UIKit

class HeaderSelectMark: UIView {
    
    private let titlePrimery = UILabel()
    
    var typeSelectMark: TypeSelectMark!
    
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
        switch typeSelectMark {
        case .multi:
            titlePrimery.text = "Выберите несколько меток"
        case .single:
            titlePrimery.text = "Выберите одну метку"
        default:
            titlePrimery.text = "Выберите метку"
        }
        layoutIfNeeded()
    }
}


extension HeaderSelectMark {
    
    private func createSubViews() {
        createTitle()
    }
    
    private func createTitle() {
        addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 32, weight: .light)
        titlePrimery.textColor = darkBlue
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
