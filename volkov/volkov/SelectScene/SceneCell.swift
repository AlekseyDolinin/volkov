import UIKit

final class SceneCell: UITableViewCell {
    
    private let backView = UIView()
    private let name = UILabel()
    private let mark = UIImageView()
    
    var nameScene: String! {
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
        name.text = nameScene
        
        mark.isHidden = Bool.random()
    }
}


extension SceneCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createMark()
    }

    private func createBackView() {
        contentView.addSubview(backView)
        backView.backgroundColor = darkBlue?.withAlphaComponent(0.1)
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
        name.textColor = darkBlue
        name.textAlignment = .center
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        name.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -24).isActive = true
        name.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func createMark() {
        backView.addSubview(mark)
        mark.tintColor = darkBlue
        mark.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        mark.image = UIImage(systemName: "exclamationmark.square.fill", withConfiguration: configuration)
        //
        mark.translatesAutoresizingMaskIntoConstraints = false
        mark.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -4).isActive = true
        mark.topAnchor.constraint(equalTo: backView.topAnchor, constant: 4).isActive = true
        mark.widthAnchor.constraint(equalToConstant: 24).isActive = true
        mark.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
