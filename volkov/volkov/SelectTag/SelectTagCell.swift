import UIKit

enum TypeSelectTag {
    case single
    case multi
}

final class SelectTagCell: UICollectionViewCell {
    
    static let identifier = "SelectTagCellIdentifier"
    
    private let backView = UIView()
    private let name = UILabel()
    private let markSignificant = UIImageView()
    
    var selectTagsIDThisCategory = [Int]()
    var tag_: Tag! {
        didSet { setCell() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        name.text = tag_.name
        setMarkSignificant()
        setSelectTag()
    }
    
    private func setSelectTag() {
        if !selectTagsIDThisCategory.contains(tag_.id) {
            backView.backgroundColor = .white.withAlphaComponent(0.1)
        } else {
            backView.backgroundColor = .white.withAlphaComponent(0.3)
        }
    }
    
    private func setMarkSignificant() {
        markSignificant.isHidden = !tag_.isSignificant
    }
}


extension SelectTagCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createMarkSignificant()
    }

    private func createBackView() {
        contentView.addSubview(backView)
        backView.layer.cornerRadius = 8.0
        backView.clipsToBounds = true
        //
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func createName() {
        backView.addSubview(name)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 4
        name.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        name.textAlignment = .center
        name.textColor = .white
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        name.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -24).isActive = true
        name.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
