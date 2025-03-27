
import UIKit

public protocol CustomTabBarDelegate: AnyObject {
    func tabBarDidSelect(indexTabBar: Int)
}

public class CustomTabBar: UIView {
    //MARK: Contants
    enum Constants {
        static let insets = UIEdgeInsets(top: 14.adaptedHeight, left: 24.adaptedWidth, bottom: -14.adaptedHeight, right: -24.adaptedWidth)
    }
    
    // MARK: - Properties
    weak var delegate: CustomTabBarDelegate?
    private var buttons: [UIButton] = []
    private let icons = ["moon", "house", "magazine", "person"]
    
    // MARK: - UI Elements
    lazy var itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - Private Methods
private extension CustomTabBar {
    // MARK: - UI Setup
    func configureUI() {
        
        icons.enumerated().forEach { index, icon in
            let button = createTabButton(with: icon, isSelected: index == 0)
            buttons.append(button)
            itemStackView.addArrangedSubview(button)
        }
        
        addSubview(itemStackView)
        
        NSLayoutConstraint.activate([
            itemStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            itemStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            itemStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            itemStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Button Creation
    func createTabButton(with icon: String, isSelected: Bool) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: icon), for: .normal)
        button.tintColor = isSelected ? AppColor.tabBarActive.color : AppColor.tabBarInactive.color
        button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - Button Actions
    @objc private func tabTapped(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        updateSelection(for: index)
        delegate?.tabBarDidSelect(indexTabBar: index)
    }
    
    // MARK: - Selection Update
    func updateSelection(for indexTabBar: Int) {
        buttons.enumerated().forEach { index, button in
            let isSelected = index == indexTabBar
            UIView.animate(withDuration: 0.2) {
                button.tintColor = isSelected ? AppColor.tabBarActive.color : AppColor.tabBarInactive.color
                button.transform = isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : .identity
            }
        }
    }
}

