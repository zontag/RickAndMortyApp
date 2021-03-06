import UIKit

class FilterHeaderView: UIView {
    
    let titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializer()
    }
    
    private func initializer() {
        self.clipsToBounds = true
        self.titleLabel.textColor = .tableViewSectionTitleColor
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.top.equalTo(self.snp.top).offset(20)
        }
    }
    
    func setTitle(_ text: String) {
        self.titleLabel.text = text
    }
}
