import UIKit

final class PerformanceCell: UITableViewCell {
    
    static let identifier = "PerformanceCellIdentifier"
    
    private let backView = UIView()
    private let name = UILabel()
    private let city = UILabel()
    private let stack = UIStackView()
    
    private let titleTeatr = UILabel()
    private let titleDirector = UILabel()
    private let titlePlaywright = UILabel()
    
    private let teatr = UILabel()
    private let director = UILabel()
    private let playwright = UILabel()
    
    private let stackIcon = UIStackView()
    private let iconInternational = UIButton()
    private let iconFiveYearTour = UIButton()
    private let iconTVversion = UIButton()
    private let iconTenYearRepertory = UIButton()
    private let iconReward = UIButton()
    
    
    var performance: Performance! {
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
        name.text = performance.name
        city.text = performance.city + "/" + performance.year
        teatr.text = performance.theater
        director.text = performance.director
        playwright.text = performance.playwright == "" ? "--" : performance.playwright
        //
        iconInternational.isHidden = !performance.isInternational
        iconFiveYearTour.isHidden = !performance.hasFiveYearTour
        iconTVversion.isHidden = !performance.hasTVscreenVersion
        iconTenYearRepertory.isHidden = !performance.hasTenYearRepertory
        iconReward.isHidden = !performance.hasReward
    }
}


extension PerformanceCell {
    
    private func createSubviews() {
        createBackView()
        createName()
        createCity()
        createStackTitles()
        createTitleTeatr()
        createTitleDirector()
        createTitlePlaywright()
        createTeatr()
        createDirector()
        createPlaywright()
        createStackIcon()
        createIconInternational()
        createIconFiveYearTour()
        createIconTVversion()
        createIconTenYearRepertory()
        createIconReward()
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
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        name.textColor = .white
        //
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
        name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 16).isActive = true
    }
    
    private func createCity() {
        backView.addSubview(city)
        city.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        city.textColor = .lightGray
        //
        city.translatesAutoresizingMaskIntoConstraints = false
        city.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        city.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
        city.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -32).isActive = true
    }
    
    private func createStackTitles() {
        backView.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        //
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 24).isActive = true
        stack.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -16).isActive = true
        stack.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
    }
        
    private func createTitleTeatr() {
        stack.addArrangedSubview(titleTeatr)
        titleTeatr.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleTeatr.textColor = .gray
        titleTeatr.text = "театр:"
    }
    
    private func createTitleDirector() {
        stack.addArrangedSubview(titleDirector)
        titleDirector.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleDirector.textColor = .gray
        titleDirector.text = "режиссер:"
    }
    
    private func createTitlePlaywright() {
        stack.addArrangedSubview(titlePlaywright)
        titlePlaywright.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titlePlaywright.textColor = .gray
        titlePlaywright.text = "драматург:"
    }
    
    private func createTeatr() {
        backView.addSubview(teatr)
        teatr.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        teatr.textColor = .lightGray
        //
        teatr.translatesAutoresizingMaskIntoConstraints = false
        teatr.bottomAnchor.constraint(equalTo: titleTeatr.bottomAnchor).isActive = true
        teatr.leftAnchor.constraint(equalTo: backView.centerXAnchor, constant: -80).isActive = true
        teatr.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -32).isActive = true
    }
    
    private func createDirector() {
        backView.addSubview(director)
        director.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        director.textColor = .lightGray
        //
        director.translatesAutoresizingMaskIntoConstraints = false
        director.bottomAnchor.constraint(equalTo: titleDirector.bottomAnchor).isActive = true
        director.leftAnchor.constraint(equalTo: backView.centerXAnchor, constant: -80).isActive = true
        director.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -32).isActive = true
    }
    
    private func createPlaywright() {
        backView.addSubview(playwright)
        playwright.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        playwright.textColor = .lightGray
        //
        playwright.translatesAutoresizingMaskIntoConstraints = false
        playwright.bottomAnchor.constraint(equalTo: titlePlaywright.bottomAnchor).isActive = true
        playwright.leftAnchor.constraint(equalTo: backView.centerXAnchor, constant: -80).isActive = true
        playwright.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -32).isActive = true
    }
    
    private func createStackIcon() {
        backView.addSubview(stackIcon)
        stackIcon.axis = .vertical
        stackIcon.spacing = 4
        stackIcon.alignment = .bottom
        //
        stackIcon.translatesAutoresizingMaskIntoConstraints = false
        stackIcon.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
        stackIcon.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0).isActive = true
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
        iconInternational.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
        iconFiveYearTour.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
        iconTVversion.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
        iconTenYearRepertory.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
        iconReward.heightAnchor.constraint(equalToConstant: 24).isActive = true
        iconReward.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
