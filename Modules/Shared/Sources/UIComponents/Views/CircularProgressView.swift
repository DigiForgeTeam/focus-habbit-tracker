
import UIKit

final class CircularProgressView: UIView {
    
    // MARK: - Views
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    // MARK: - Private Properties
    private var isRounded: Bool
    private var lineWidth: CGFloat
    private var lastBounds: CGRect = .zero
    
    // MARK: - Init
    init(isRounded: Bool,
         lineWidth: CGFloat) {
        self.isRounded = isRounded
        self.lineWidth = lineWidth
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    // MARK: - Methods
    func setProgress(_ progress: CGFloat,
                            animated: Bool = true) {
        let clampedProgress = max(0, min(progress, 1))
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = clampedProgress
            animation.duration = 0.4
            progressLayer.add(animation, forKey: "progressAnimation")
        }
        
        progressLayer.strokeEnd = clampedProgress
    }
}

// MARK: - Private Methods
private extension CircularProgressView {
    
    // MARK: - Setup View
    func setupView() {
        guard bounds != lastBounds else { return }
        lastBounds = bounds
        
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let startAngle = -CGFloat.pi / 2   // 12 часов (начало)
        let endAngle = startAngle + 2 * CGFloat.pi  // Полный круг до 12 часов
        
        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        setupTrackLayer(with: circlePath)
        setupProgressLayer(with: circlePath)
    }
    
    // MARK: - Setup Track Layer
    func setupTrackLayer(with path: UIBezierPath) {
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = AppColor.background.color.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(trackLayer)
    }
    
    // MARK: - Setup Progress Layer
    func setupProgressLayer(with path: UIBezierPath) {
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = AppColor.tabBarActive.color.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        
        if isRounded {
            progressLayer.lineCap = .round
        }
        
        layer.addSublayer(progressLayer)
    }
}

