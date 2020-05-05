import Foundation
import UIKit

extension UIBarButtonItem {
    func plainStyle() -> UIBarButtonItem {
        self.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ], for: .normal)
        self.tintColor = .primary
        return self
    }
}
