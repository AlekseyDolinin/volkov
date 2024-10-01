//import UIKit
//
//final class PerformanceCell: UITableViewCell {
//    
//    private let backView = UIView()
//    private let name = UILabel()
//    private let genre = UILabel()
//    private let director = UILabel()
//    private let year = UILabel()
//    
//    var namePerformance: String! {
//        didSet { setCell() }
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear
//        selectionStyle = .none
//        createSubviews()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    private func setCell() {
//        name.text = namePerformance
//        genre.text = "Трагикомедия"
//        director.text = "Кшиштоф Варликовский"
//        year.text = "1984"
//    }
//}
//
//
//extension PerformanceCell {
//    
//    private func createSubviews() {
//        createBackView()
//        createGenre()
//        createYear()
//        createName()
//        createDirector()
//        
//    }
//
//    private func createBackView() {
//        contentView.addSubview(backView)
//        backView.backgroundColor = .white.withAlphaComponent(0.1)
//        backView.layer.cornerRadius = 8.0
//        backView.clipsToBounds = true
//        //
//        backView.translatesAutoresizingMaskIntoConstraints = false
//        backView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
//        backView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
//        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
//        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//    
//    private func createGenre() {
//        backView.addSubview(genre)
//        genre.lineBreakMode = .byWordWrapping
//        genre.numberOfLines = 0
//        genre.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        genre.textColor = .white
//        //
//        genre.translatesAutoresizingMaskIntoConstraints = false
//        genre.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
//        genre.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
//    }
//    
//    private func createYear() {
//        backView.addSubview(year)
//        year.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        year.textColor = .white
//        //
//        year.translatesAutoresizingMaskIntoConstraints = false
//        year.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8).isActive = true
//        year.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
//    }
//    
//    private func createName() {
//        backView.addSubview(name)
//        name.lineBreakMode = .byWordWrapping
//        name.numberOfLines = 0
//        name.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        name.textColor = .white
//        //
//        name.translatesAutoresizingMaskIntoConstraints = false
//        name.topAnchor.constraint(equalTo: genre.bottomAnchor, constant: 4).isActive = true
//        name.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
//        name.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
//    }
//        
//    private func createDirector() {
//        backView.addSubview(director)
//        director.lineBreakMode = .byWordWrapping
//        director.numberOfLines = 0
//        director.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        director.textColor = .white
//        //
//        director.translatesAutoresizingMaskIntoConstraints = false
//        director.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8).isActive = true
//        director.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8).isActive = true
//        director.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 16).isActive = true
//        director.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -16).isActive = true
//    }
//}
