import UIKit

final class SceneCell: UITableViewCell {
    
    static let identifier = "SceneCellIdentifier"
    
    private let backView = UIView()
    private let name = UILabel()
    private let markSignificant = UIImageView()
    private let markMultiCategory = UIImageView()
    private let markFinal = UIImageView()
    
    var scene: Scene! {
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
        name.text = scene.name
        setMarkSignificant()
        setMarkMultiCategory()
        setMarkFinal()
    }
    
    private func setMarkSignificant() {
        let savedTags = LocalStorage.shared.savedIDsTags
        var sceneTags: [Tag] = []
        let sceneСategories = scene.categories
        for i in sceneСategories {
            sceneTags += i.tags
        }
        let sceneIDsTags = sceneTags.map({ $0.id })
        let setSavedTags: Set<Int> = Set(savedTags)
        let setSceneIDsTags: Set<Int> = Set(sceneIDsTags)
        let intersection = setSavedTags.intersection(setSceneIDsTags)
        markSignificant.isHidden = intersection.isEmpty
    }
    
    private func setMarkMultiCategory() {
        markMultiCategory.isHidden = scene.categories.count == 1
    }
    
    private func setMarkFinal() {
        markFinal.isHidden = !scene.isFinal
    }
}


extension SceneCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createMarkSignificant()
        createMarkMultiCategory()
        createMarkFinal()
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
        backView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func createName() {
        backView.addSubview(name)
        name.lineBreakMode = .byTruncatingTail
        name.numberOfLines = 3
        name.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        name.textColor = .white
        name.textAlignment = .center
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
        name.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
    }
    
    private func createMarkSignificant() {
        backView.addSubview(markSignificant)
        markSignificant.tintColor = gold
        markSignificant.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        markSignificant.image = UIImage(systemName: "bookmark.fill", withConfiguration: configuration)
        //
        markSignificant.translatesAutoresizingMaskIntoConstraints = false
        markSignificant.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 4).isActive = true
        markSignificant.topAnchor.constraint(equalTo: backView.topAnchor, constant: -4).isActive = true
        markSignificant.widthAnchor.constraint(equalToConstant: 24).isActive = true
        markSignificant.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func createMarkMultiCategory() {
        backView.addSubview(markMultiCategory)
        markMultiCategory.tintColor = gold
        markMultiCategory.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular)
        markMultiCategory.image = UIImage(systemName: "ellipsis.rectangle.fill", withConfiguration: configuration)
        //
        markMultiCategory.translatesAutoresizingMaskIntoConstraints = false
        markMultiCategory.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -8).isActive = true
        markMultiCategory.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -4).isActive = true
        markMultiCategory.widthAnchor.constraint(equalToConstant: 24).isActive = true
        markMultiCategory.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    private func createMarkFinal() {
        backView.addSubview(markFinal)
        markFinal.tintColor = gold
        markFinal.contentMode = .center
        let configuration = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        markFinal.image = UIImage(systemName: "flag.filled.and.flag.crossed", withConfiguration: configuration)
        //
        markFinal.translatesAutoresizingMaskIntoConstraints = false
        markFinal.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -8).isActive = true
        markFinal.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        markFinal.widthAnchor.constraint(equalToConstant: 24).isActive = true
        markFinal.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
}
