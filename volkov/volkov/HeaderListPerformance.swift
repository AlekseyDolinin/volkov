import UIKit

class HeaderListPerformance: UIView {
    
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
}


extension HeaderListPerformance {
    
    private func createSubViews() {
        createTitle()
    }
    
    private func createTitle() {
        addSubview(titlePrimery)
        titlePrimery.text = "Подобраные спектакли"
        titlePrimery.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        titlePrimery.textColor = .white
        titlePrimery.textAlignment = .center
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titlePrimery.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
}
