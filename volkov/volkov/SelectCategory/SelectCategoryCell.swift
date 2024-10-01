import UIKit

final class SelectCategoryCell: UITableViewCell {
    
    static let identifier = "SelectCategoryCellIdentifier"
    
    private let backView = UIView()
    private let name = UILabel()
    private let markSignificant = UIImageView()
    
    var category: Category! {
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
        name.text = category.name
        setMarkSignificant()
    }
    
    private func setMarkSignificant() {
        markSignificant.isHidden = !category.isSignificant
    }
}


extension SelectCategoryCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createMarkSignificant()
    }

    private func createBackView() {
        contentView.addSubview(backView)
        backView.backgroundColor = .white.withAlphaComponent(0.1)
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
        name.textColor = .white
        name.textAlignment = .center
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        name.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -24).isActive = true
        name.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func createMarkSignificant() {
        backView.addSubview(markSignificant)
        markSignificant.tintColor = gold
        markSignificant.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        markSignificant.image = UIImage(systemName: "bookmark.fill", withConfiguration: configuration)
        //
        markSignificant.translatesAutoresizingMaskIntoConstraints = false
        markSignificant.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -4).isActive = true
        markSignificant.topAnchor.constraint(equalTo: backView.topAnchor, constant: -4).isActive = true
        markSignificant.widthAnchor.constraint(equalToConstant: 24).isActive = true
        markSignificant.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
