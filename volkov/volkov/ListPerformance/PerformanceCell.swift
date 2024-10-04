import UIKit

final class PerformanceCell: UITableViewCell {
    
    static let identifier = "PerformanceCellIdentifier"
    
    private let backView = UIView()
    private let name = UILabel()
    private let markSignificant = UIImageView()
    private let markMultiCategory = UIImageView()
    private let markFinal = UIImageView()
    
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
    }
}


extension PerformanceCell {
    
    private func createSubviews() {
        createBackView()
        createName()
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
}
