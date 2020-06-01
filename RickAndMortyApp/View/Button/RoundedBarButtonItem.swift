import UIKit

class RoundedBarButtonItem: UIBarButtonItem {
    convenience init(title: String, target: AnyObject?, action: Selector) {
        let customButton = UIButton(type: .custom)
        customButton.setTitle(title, for: .normal)
        customButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = UIColor.primary
        customButton.layer.cornerRadius = 14
        customButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
        customButton.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: customButton)
    }
}
