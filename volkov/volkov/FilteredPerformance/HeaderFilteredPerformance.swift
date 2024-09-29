import UIKit

class HeaderFilteredPerformance: UIView {
    
    private let titlePrimery = UILabel()
    
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

        layoutIfNeeded()
    }
}


extension HeaderFilteredPerformance {
    
    private func createSubViews() {
        createTitle()
    }
    
    private func createTitle() {
        addSubview(titlePrimery)
        titlePrimery.text = "Подходящие постановки"
        titlePrimery.font = UIFont.systemFont(ofSize: 32, weight: .light)
        titlePrimery.textColor = darkBlue
        titlePrimery.textAlignment = .center
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        titlePrimery.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
