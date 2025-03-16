

import UIKit

public protocol CustomNavBarDelegate: AnyObject {
    func backButtonTapped()
}

public class CustomNavigationBar: UIView {
    // MARK: - Constants
    enum Constants {
        enum Button {
            static let size = CGSize(width: 13.adaptedWidth, height: 17.adaptedHeight)
            static let shadowColor = UIColor.white.cgColor
            static let shadowOpacity: Float = 0.2
            static let shadowOffset = CGSize(width: 0, height: 2)
            static let shadowRadius: CGFloat = 4
        }
    }
    
    // MARK: - Properties
    weak var delegate: CustomNavBarDelegate?
    
    // MARK: - UI Elements
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
#warning("Заменить шрифт")
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = AppColor.primaryText.color
        label.textAlignment = .center
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        button.layer.shadowColor = Constants.Button.shadowColor
        button.layer.shadowOpacity = Constants.Button.shadowOpacity
        button.layer.shadowOffset = Constants.Button.shadowOffset
        button.layer.shadowRadius = Constants.Button.shadowRadius
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Public Methods
public extension CustomNavigationBar {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func showBackButton(_ show: Bool) {
        backButton.isHidden = !show
    }
}

// MARK: - Private Methods
private extension CustomNavigationBar {
    private func configureUI() {
        
        addSubview(backButton)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc func backTapped() {
        delegate?.backButtonTapped()
    }
}

