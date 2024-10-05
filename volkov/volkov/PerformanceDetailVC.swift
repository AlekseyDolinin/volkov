import UIKit

class PerformanceDetailVC: GeneralViewController {
    
    private var topView = UIView()
    private var closeButton = UIButton()
    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let poster = UIImageView()
    private let name = UILabel()
    private let city = UILabel()
    private let description_ = UILabel()
    private let titleTeatr = UILabel()
    private let teatr = UILabel()
    private let titleDirector = UILabel()
    private let director = UILabel()
    private let titlePlaywright = UILabel()
    private let playwright = UILabel()
    private let separator = UIView()
    private let stackIcon = UIStackView()
    private let iconInternational = UIButton()
    private let iconFiveYearTour = UIButton()
    private let iconTVversion = UIButton()
    private let iconTenYearRepertory = UIButton()
    private let iconReward = UIButton()
    private let separatorTwo = UIView()
    private let desInternational = UILabel()
    private let desFiveYearTour = UILabel()
    private let desTVversion = UILabel()
    private let desTenYearRepertory = UILabel()
    private let desReward = UILabel()
    private let titleTags = UILabel()
    private let stackTags = UIStackView()
    
    private var performance: Performance!
    
    init(performance: Performance) {
        super.init(nibName: nil, bundle: nil)
        print(performance)
        self.performance = performance
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
        addTags()
        setIcons()
        setPoster()
    }
    
    private func addTags() {
        let tags = performance.notSelectedSabels.map({ $0.name })
        stackTags.subviews.forEach { view in
            view.removeFromSuperview()
        }
        for i in tags {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = .white
            label.text = i
            stackTags.addArrangedSubview(label)
        }
    }
    
    private func setPoster() {
        if performance.image != "" {
            Task(priority: .userInitiated) {
                let link = "https://mirteatr.vovlekay.online/\(performance.image)"
                let image = await API.shared.requestImage(link: link)
                DispatchQueue.main.async {
                    self.poster.image = image
                }
            }
        }
    }
    
    private func setIcons() {
        
        if performance.isInternational == false 
            && performance.hasFiveYearTour == false
            && performance.hasTVscreenVersion == false
            && performance.hasTenYearRepertory == false
            && performance.hasTenYearRepertory == false
            && performance.hasReward == false {
            separatorTwo.isHidden = true
            titleTags.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 24).isActive = true
        }
        
        iconInternational.isHidden = !performance.isInternational
        desInternational.isHidden = !performance.isInternational
        iconFiveYearTour.isHidden = !performance.hasFiveYearTour
        desFiveYearTour.isHidden = !performance.hasFiveYearTour
        iconTVversion.isHidden = !performance.hasTVscreenVersion
        desTVversion.isHidden = !performance.hasTVscreenVersion
        iconTenYearRepertory.isHidden = !performance.hasTenYearRepertory
        desTenYearRepertory.isHidden = !performance.hasTenYearRepertory
        iconReward.isHidden = !performance.hasReward
        desReward.isHidden = !performance.hasReward
    }
}


extension PerformanceDetailVC {
    
    private func createSubviews() {
        createTopView()
        createCloseButton()
        createScroll()
        createViewBack()
        createPoster()
        createName()
        createCity()
        createDescription()
        createTitleTeatr()
        createTeatr()
        createTitleDirector()
        createDirector()
        createTitlePlaywright()
        createPlaywright()
        createSeparator()
        createStackIcon()
        createIconInternational()
        createIconFiveYearTour()
        createIconTVversion()
        createIconTenYearRepertory()
        createIconReward()
        createDesInternational()
        createDesFiveYearTour()
        createDesTVversion()
        createDesTenYearRepertory()
        createDesReward()
        createSeparatorTwo()
        createTitleTags()
        createStackTags()
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
    
    private func createScroll() {
        view.addSubview(scroll)
        scroll.alwaysBounceVertical = true
        scroll.keyboardDismissMode = .onDrag
        scroll.backgroundColor = .clear
        //
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scroll.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scroll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func createViewBack() {
        scroll.addSubview(viewBack)
        viewBack.backgroundColor = .clear
        //
        viewBack.translatesAutoresizingMaskIntoConstraints = false
        viewBack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor).isActive = true
        viewBack.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        viewBack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
        viewBack.leftAnchor.constraint(equalTo: scroll.leftAnchor).isActive = true
        viewBack.rightAnchor.constraint(equalTo: scroll.rightAnchor).isActive = true
    }
    
    private func createPoster() {
        viewBack.addSubview(poster)
        poster.backgroundColor = .darkGray.withAlphaComponent(0.5)
        poster.layer.cornerRadius = 16.0
        poster.clipsToBounds = true
        poster.tintColor = .darkGray
        poster.image = UIImage(named: "pl")
        poster.contentMode = .scaleAspectFill
        //
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 8).isActive = true
        poster.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        poster.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        poster.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 32) / 16 * 9).isActive = true
    }
    
    private func createName() {
        viewBack.addSubview(name)
        name.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        name.textColor = .white
        name.text = performance.name
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 8).isActive = true
        name.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createCity() {
        viewBack.addSubview(city)
        city.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        city.textColor = .gray
        city.text = performance.city + "/" + performance.year
        //
        city.translatesAutoresizingMaskIntoConstraints = false
        city.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        city.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        city.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createDescription() {
        viewBack.addSubview(description_)
        description_.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        description_.textColor = .white
        description_.text = performance.description
        description_.numberOfLines = 0
        description_.lineBreakMode = .byWordWrapping
        //
        description_.translatesAutoresizingMaskIntoConstraints = false
        description_.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 16).isActive = true
        description_.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        description_.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
    
    private func createTitleTeatr() {
        viewBack.addSubview(titleTeatr)
        titleTeatr.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleTeatr.textColor = .gray
        titleTeatr.text = "театр:"
        //
        titleTeatr.translatesAutoresizingMaskIntoConstraints = false
        titleTeatr.topAnchor.constraint(equalTo: description_.bottomAnchor, constant: 24).isActive = true
        titleTeatr.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createTeatr() {
        viewBack.addSubview(teatr)
        teatr.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        teatr.textColor = .lightGray
        teatr.text = performance.theater
        //
        teatr.translatesAutoresizingMaskIntoConstraints = false
        teatr.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 116).isActive = true
        teatr.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        teatr.bottomAnchor.constraint(equalTo: titleTeatr.bottomAnchor).isActive = true
    }
    
    private func createTitleDirector() {
        viewBack.addSubview(titleDirector)
        titleDirector.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleDirector.textColor = .gray
        titleDirector.text = "режиссер:"
        //
        titleDirector.translatesAutoresizingMaskIntoConstraints = false
        titleDirector.topAnchor.constraint(equalTo: teatr.bottomAnchor, constant: 16).isActive = true
        titleDirector.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createDirector() {
        viewBack.addSubview(director)
        director.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        director.textColor = .lightGray
        director.text = performance.director
        //
        director.translatesAutoresizingMaskIntoConstraints = false
        director.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 116).isActive = true
        director.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        director.bottomAnchor.constraint(equalTo: titleDirector.bottomAnchor).isActive = true
    }
    
    private func createTitlePlaywright() {
        viewBack.addSubview(titlePlaywright)
        titlePlaywright.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titlePlaywright.textColor = .gray
        titlePlaywright.text = "драматург:"
        //
        titlePlaywright.translatesAutoresizingMaskIntoConstraints = false
        titlePlaywright.topAnchor.constraint(equalTo: director.bottomAnchor, constant: 16).isActive = true
        titlePlaywright.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
    }
    
    private func createPlaywright() {
        viewBack.addSubview(playwright)
        playwright.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        playwright.textColor = .lightGray
        playwright.text = performance.playwright == "" ? "--" : performance.playwright
        //
        playwright.translatesAutoresizingMaskIntoConstraints = false
        playwright.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 116).isActive = true
        playwright.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        playwright.bottomAnchor.constraint(equalTo: titlePlaywright.bottomAnchor).isActive = true
    }
    
    private func createSeparator() {
        viewBack.addSubview(separator)
        separator.backgroundColor = .darkGray
        //
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separator.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.topAnchor.constraint(equalTo: playwright.bottomAnchor, constant: 24).isActive = true
    }
    
    private func createStackIcon() {
        viewBack.addSubview(stackIcon)
        stackIcon.axis = .vertical
        stackIcon.spacing = 8
        //
        stackIcon.translatesAutoresizingMaskIntoConstraints = false
        stackIcon.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 24).isActive = true
        stackIcon.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 8).isActive = true
    }
    
    private func createIconInternational() {
        stackIcon.addArrangedSubview(iconInternational)
        iconInternational.contentMode = .center
        iconInternational.tintColor = gold
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let icon = UIImage(systemName: "network", withConfiguration: configuration)
        iconInternational.setImage(icon, for: .normal)
        iconInternational.isHidden = true
        //
        iconInternational.translatesAutoresizingMaskIntoConstraints = false
        iconInternational.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconInternational.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createIconFiveYearTour() {
        stackIcon.addArrangedSubview(iconFiveYearTour)
        iconFiveYearTour.contentMode = .center
        iconFiveYearTour.tintColor = gold
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let icon = UIImage(systemName: "5.circle", withConfiguration: configuration)
        iconFiveYearTour.setImage(icon, for: .normal)
        iconFiveYearTour.isHidden = true
        //
        iconFiveYearTour.translatesAutoresizingMaskIntoConstraints = false
        iconFiveYearTour.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconFiveYearTour.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createIconTVversion() {
        stackIcon.addArrangedSubview(iconTVversion)
        iconTVversion.contentMode = .center
        iconTVversion.tintColor = gold
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let icon = UIImage(systemName: "play.tv.fill", withConfiguration: configuration)
        iconTVversion.setImage(icon, for: .normal)
        iconTVversion.isHidden = true
        //
        iconTVversion.translatesAutoresizingMaskIntoConstraints = false
        iconTVversion.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconTVversion.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createIconTenYearRepertory() {
        stackIcon.addArrangedSubview(iconTenYearRepertory)
        iconTenYearRepertory.contentMode = .center
        iconTenYearRepertory.tintColor = gold
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let icon = UIImage(systemName: "10.square.fill", withConfiguration: configuration)
        iconTenYearRepertory.setImage(icon, for: .normal)
        iconTenYearRepertory.isHidden = true
        //
        iconTenYearRepertory.translatesAutoresizingMaskIntoConstraints = false
        iconTenYearRepertory.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconTenYearRepertory.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func createIconReward() {
        stackIcon.addArrangedSubview(iconReward)
        iconReward.imageView?.contentMode = .center
        iconReward.tintColor = gold
        let configuration = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let icon = UIImage(systemName: "star.circle.fill", withConfiguration: configuration)
        iconReward.setImage(icon, for: .normal)
        iconReward.isHidden = true
        //
        iconReward.translatesAutoresizingMaskIntoConstraints = false
        iconReward.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconReward.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
        
    private func createDesInternational() {
        viewBack.addSubview(desInternational)
        desInternational.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        desInternational.textColor = .lightGray
        desInternational.text = "Выход на международный уровень"
        //
        desInternational.translatesAutoresizingMaskIntoConstraints = false
        desInternational.leftAnchor.constraint(equalTo: iconInternational.rightAnchor, constant: 4).isActive = true
        desInternational.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        desInternational.centerYAnchor.constraint(equalTo: iconInternational.centerYAnchor).isActive = true
    }
    
    private func createDesFiveYearTour() {
        viewBack.addSubview(desFiveYearTour)
        desFiveYearTour.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        desFiveYearTour.textColor = .lightGray
        desFiveYearTour.text = "Продолжительность гастролей более 5 лет"
        //
        desFiveYearTour.translatesAutoresizingMaskIntoConstraints = false
        desFiveYearTour.leftAnchor.constraint(equalTo: iconFiveYearTour.rightAnchor, constant: 4).isActive = true
        desFiveYearTour.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        desFiveYearTour.centerYAnchor.constraint(equalTo: iconFiveYearTour.centerYAnchor).isActive = true
    }
    
    private func createDesTVversion() {
        viewBack.addSubview(desTVversion)
        desTVversion.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        desTVversion.textColor = .lightGray
        desTVversion.text = "desTVversion"
        //
        desTVversion.translatesAutoresizingMaskIntoConstraints = false
        desTVversion.leftAnchor.constraint(equalTo: iconTVversion.rightAnchor, constant: 4).isActive = true
        desTVversion.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        desTVversion.centerYAnchor.constraint(equalTo: iconTVversion.centerYAnchor).isActive = true
    }
    
    private func createDesTenYearRepertory() {
        viewBack.addSubview(desTenYearRepertory)
        desTenYearRepertory.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        desTenYearRepertory.textColor = .lightGray
        desTenYearRepertory.text = "Более 10 лет в репертуаре"
        //
        desTenYearRepertory.translatesAutoresizingMaskIntoConstraints = false
        desTenYearRepertory.leftAnchor.constraint(equalTo: iconTenYearRepertory.rightAnchor, constant: 4).isActive = true
        desTenYearRepertory.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        desTenYearRepertory.centerYAnchor.constraint(equalTo: iconTenYearRepertory.centerYAnchor).isActive = true
    }
    
    private func createDesReward() {
        viewBack.addSubview(desReward)
        desReward.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        desReward.textColor = .lightGray
        desReward.text = "Наличие наград"
        //
        desReward.translatesAutoresizingMaskIntoConstraints = false
        desReward.leftAnchor.constraint(equalTo: iconReward.rightAnchor, constant: 4).isActive = true
        desReward.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        desReward.centerYAnchor.constraint(equalTo: iconReward.centerYAnchor).isActive = true
    }
    
    private func createSeparatorTwo() {
        viewBack.addSubview(separatorTwo)
        separatorTwo.backgroundColor = .darkGray
        //
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        separatorTwo.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        separatorTwo.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        separatorTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorTwo.topAnchor.constraint(equalTo: stackIcon.bottomAnchor, constant: 24).isActive = true
    }
    
    private func createTitleTags() {
        viewBack.addSubview(titleTags)
        titleTags.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleTags.textColor = .white
        titleTags.text = "Невыбранные метки:"
        //
        titleTags.translatesAutoresizingMaskIntoConstraints = false
        titleTags.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        titleTags.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
        titleTags.topAnchor.constraint(equalTo: separatorTwo.bottomAnchor, constant: 24).isActive = true
    }
        
    private func createStackTags() {
        viewBack.addSubview(stackTags)
        stackTags.axis = .vertical
        stackTags.spacing = 12
        //
        stackTags.translatesAutoresizingMaskIntoConstraints = false
        stackTags.topAnchor.constraint(equalTo: titleTags.bottomAnchor, constant: 24).isActive = true
        stackTags.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -80).isActive = true
        stackTags.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        stackTags.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
}
