import Foundation
import UIKit

extension UIBarButtonItem {
    
    static func createRounded(title: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let customButton = UIButton(type: .custom)
        customButton.setTitle(title, for: .normal)
        customButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = UIColor.primary
        customButton.layer.cornerRadius = 14
        customButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        customButton.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: customButton)
    }
    
    static func createPlain(title: String, target: AnyObject?, action: Selector?) -> UIBarButtonItem {
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        barButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ], for: .normal)
        barButton.tintColor = .primary
        return barButton
    }
}
