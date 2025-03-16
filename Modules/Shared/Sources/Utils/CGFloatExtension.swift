
import UIKit

// MARK: - Extension CGFloat
public extension CGFloat {
    
    // MARK: - Properties
    var adaptedHeight: CGFloat {
        return self * (UIScreen.main.bounds.height / 812.0)
    }
    
    var adaptedWidth: CGFloat {
        return self * (UIScreen.main.bounds.width / 375.0)
    }
}
