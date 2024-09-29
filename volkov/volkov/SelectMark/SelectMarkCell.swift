import UIKit

final class SelectMarkCell: UITableViewCell {
    
    private let backView = UIView()
    private let name = UILabel()
    private let checkIcon = UIImageView()
    
    var isSelect: Bool = false
    var nameMark: String! {
        didSet { setCell() }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setCell() {
        name.text = nameMark
        if isSelect {
            backView.backgroundColor = darkBlue
            name.textColor = .white
            checkIcon.isHidden = false
        } else {
            backView.backgroundColor = darkBlue?.withAlphaComponent(0.1)
            name.textColor = darkBlue
            checkIcon.isHidden = true
        }
    }
}


extension SelectMarkCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createCheckIcon()
    }

    private func createBackView() {
        contentView.addSubview(backView)
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func createName() {
        backView.addSubview(name)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 4
        name.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        name.textAlignment = .center
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        name.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -24).isActive = true
        name.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func createCheckIcon() {
        backView.addSubview(checkIcon)
        checkIcon.tintColor = .white
        checkIcon.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        checkIcon.image = UIImage(systemName: "checkmark.square.fill", withConfiguration: configuration)
        //
        checkIcon.translatesAutoresizingMaskIntoConstraints = false
        checkIcon.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -4).isActive = true
        checkIcon.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4).isActive = true
        checkIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        checkIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
