import UIKit

class PerformanceDetailVC: GeneralViewController {
    
    private var topView = UIView()
    private var closeButton = UIButton()
    private let scroll = UIScrollView()
    private let viewBack = UIView()
    private let titlePrimery = UILabel()
    
    
    
    private var performance: Performance! {
        didSet {
            if performance == nil { return }
            print(performance)
        }
    }
        
    init(performance: Performance) {
        super.init(nibName: nil, bundle: nil)
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
    }
}


extension PerformanceDetailVC {
    
    private func createSubviews() {
        createTopView()
        createCloseButton()
        createScroll()
        createViewBack()
        createTitle()
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
    
    private func createTitle() {
        viewBack.addSubview(titlePrimery)
        titlePrimery.text = "Спектакль"
        titlePrimery.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titlePrimery.textColor = .white
        titlePrimery.textAlignment = .center
        //
        titlePrimery.translatesAutoresizingMaskIntoConstraints = false
        titlePrimery.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 8).isActive = true
        titlePrimery.bottomAnchor.constraint(equalTo: viewBack.bottomAnchor, constant: -100).isActive = true
        titlePrimery.leftAnchor.constraint(equalTo: viewBack.leftAnchor, constant: 16).isActive = true
        titlePrimery.rightAnchor.constraint(equalTo: viewBack.rightAnchor, constant: -16).isActive = true
    }
}
