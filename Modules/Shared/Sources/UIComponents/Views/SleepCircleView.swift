
import UIKit

public enum TimeFormat {
    case twelveHour
    case twentyFourHour
    
    var maxHours: CGFloat {
        switch self {
        case .twelveHour: return 12
        case .twentyFourHour: return 24
        }
    }
}

public class SleepCircleView: UIView {
    
    // MARK: - Private Properties
    private let circularProgressView = CircularProgressView(isRounded: false,
                                                            lineWidth: 20)
    private let timeLabel = UILabel()
    private let dayLabel = UILabel()
    
    private let sleepHours: CGFloat
    private let currentDay: String
    private let timeFormat: TimeFormat
    
    // MARK: - Init
    public init(sleepHours: CGFloat,
         currentDay: String,
         timeFormat: TimeFormat = .twentyFourHour) {
        self.sleepHours = sleepHours
        self.currentDay = currentDay
        self.timeFormat = timeFormat
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Setup Views Methods
private extension SleepCircleView {
    
    func setupView() {
        setupCircularProgressView() // UI для отображения прогресса сна
        setupTimeLabel() // Отображение количества часов сна
        setupDayLabel() // Отображение дня
    }
    
    func setupCircularProgressView() {
        addSubview(circularProgressView)
        
        circularProgressView.setProgress(sleepHours / timeFormat.maxHours)
        
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circularProgressView.topAnchor.constraint(equalTo: self.topAnchor),
            circularProgressView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circularProgressView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            circularProgressView.heightAnchor.constraint(equalTo: circularProgressView.widthAnchor)
        ])
    }
    
    func setupTimeLabel() {
        circularProgressView.addSubview(timeLabel)
        
        timeLabel.font = UIFont(name: "SF-Pro-Display-Light", size: 12)
        timeLabel.textColor = AppColor.primaryText.color
        timeLabel.textAlignment = .center
        timeLabel.text = "\(Int(sleepHours))h"
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: circularProgressView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: circularProgressView.centerYAnchor)
        ])
    }
    
    func setupDayLabel() {
        addSubview(dayLabel)
        
        dayLabel.font = UIFont(name: "SF-Pro-Display-Light", size: 12)
        dayLabel.textColor = AppColor.primaryText.color
        dayLabel.textAlignment = .center
        dayLabel.text = currentDay
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: circularProgressView.bottomAnchor, constant: 3),
            dayLabel.heightAnchor.constraint(equalTo: circularProgressView.heightAnchor, multiplier: 0.2),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dayLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
