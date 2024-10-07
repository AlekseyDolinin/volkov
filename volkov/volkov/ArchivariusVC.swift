import UIKit

class ArchivariusVC: GeneralViewController {
    
    private var topView = UIView()
    private var closeButton = UIButton()
    private let titlePrimery = UILabel()
    private var bottomView = UIView()
    private let saveTagButton = UIButton()
    private let stack = UIStackView()
    private var selectScene: Scene!
    private var selectTagsIDThisCategory = [Int]()
    
    init(selectScene: Scene) {
        super.init(nibName: nil, bundle: nil)
        self.selectScene = selectScene
//        header.selectScene = selectScene
//        header.selectCategory = selectCategory
//        header.setView()
        
//        let tagsIDThisCategory: Set<Int> = Set(selectCategory.tags.map({ $0.id }))
        let savedIDsTags: Set<Int> = Set(LocalStorage.shared.savedIDsTags)
//        selectTagsIDThisCategory = Array(tagsIDThisCategory.intersection(savedIDsTags))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setView()
    }
    
    private func setView() {
        print("setView")
        for i in 0..<selectScene.categories.count {
            let tags = selectScene.categories[i].tags.map({ $0.name })
            let segment = UISegmentedControl(items: tags)
            segment.tag = i
            segment.selectedSegmentTintColor = .white.withAlphaComponent(0.2)
            segment.backgroundColor = .white.withAlphaComponent(0.1)
//            segment.selectedSegmentIndex = 0
            
            let font = UIFont.systemFont(ofSize: 18, weight: .medium)
            let titleTextAttributesSelect: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font
            ]
            segment.setTitleTextAttributes(titleTextAttributesSelect, for: .selected)
            let titleTextAttributesNormal: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font
            ]
            segment.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
            //
            segment.translatesAutoresizingMaskIntoConstraints = false
            segment.heightAnchor.constraint(equalToConstant: 80).isActive = true
            //
            let action = UIAction { [weak self] _ in
                self?.changeLng()
            }
            segment.addAction(action, for: .valueChanged)
            //
            stack.addArrangedSubview(segment)
        }
    }
    
    
    
    
    
    
    
    private func saveTags() {
        print("saveTags")
//        removeAllTagsThisCategory()
//        saveNewTags()
    }
    
}


extension ArchivariusVC {
    
    private func createSubviews() {
        createTopView()
        createCloseButton()
        createTitle()
        createBottomView()
        createSendMarkButton()
        createStack()
    }

    private func createTopView() {
        view.addSubview(topView)
        topView.backgroundColor = gold
        //
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createCloseButton() {
        topView.addSubview(closeButton)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }
        closeButton.addAction(action, for: .touchUpInside)
        //
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeButton.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createTitle() {
        view.addSubview(titlePrimery)
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titlePrimery.textColor = .white
        titlePrimery.lineBreakMode = .byWordWrapping
        titlePrimery.numberOfLines = 0
        titlePrimery.textAlignment = .center
        titlePrimery.text = "Драматургия"
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titlePrimery.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func createBottomView() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .black
        //
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createSendMarkButton() {
        bottomView.addSubview(saveTagButton)
        saveTagButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        saveTagButton.layer.cornerRadius = 8
        saveTagButton.setTitleColor(.black, for: .normal)
        saveTagButton.backgroundColor = gold
        saveTagButton.alpha = 0.2
        saveTagButton.isEnabled = false
        saveTagButton.setTitle("Сохранить выбор", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.saveTags()
        }
        saveTagButton.addAction(action, for: .touchUpInside)
        //
        saveTagButton.translatesAutoresizingMaskIntoConstraints = false
        saveTagButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 16).isActive = true
        saveTagButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -16).isActive = true
        saveTagButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        saveTagButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16).isActive = true
        saveTagButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func createStack() {
        print("createSendMarkButton")
        view.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        stack.topAnchor.constraint(equalTo: titlePrimery.bottomAnchor, constant: 16).isActive = true
    }
}


extension UISegmentedControl {
    func font() {
        let attributedSegmentFont = NSDictionary(
            object: UIFont.systemFont(ofSize: 100),
            forKey: NSAttributedString.Key.font as NSCopying)
        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: .normal)
    }
}
