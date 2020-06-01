import UIKit

class DotPlainBarButtonItem: UIBarButtonItem {
    
    private var iconView: UIImageView!
    
    var dotIsHidden = true {
        didSet {
            self.iconView.isHidden = dotIsHidden
        }
    }
    
    convenience init(title: String, target: AnyObject?, action: Selector) {
        let customButton = UIButton(type: .custom)
        customButton.setTitle(title, for: .normal)
        customButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        customButton.setTitleColor(.primary, for: .normal)
        customButton.addTarget(target, action: action, for: .touchUpInside)
        let iconView = UIImageView(image: #imageLiteral(resourceName: "icon_dot"))
        iconView.contentMode = .scaleAspectFit
        let hStack = UIStackView(arrangedSubviews: [iconView, customButton])
        hStack.alignment = .center
        self.init(customView: hStack)
        self.iconView = iconView
        self.iconView.isHidden = true
    }
}
