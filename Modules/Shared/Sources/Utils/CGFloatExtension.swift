
import UIKit

// MARK: - Extension CGFloat
public extension CGFloat {
    
    // MARK: - Properties
    var adaptedHeight: CGFloat {
        return self * (UIScreen.main.bounds.height / 844.0)
    }
    
    var adaptedWidth: CGFloat {
        return self * (UIScreen.main.bounds.width / 390.0)
    }
}
