import UIKit
import SnapKit
import Kingfisher

class CardCollectionViewCell: UICollectionViewCell {
    
    struct Data {
        let imageUrl: String
        let title: String
        let subtitle: String
    }
    
    static let identifier = "CardCollectionViewCell"
    
    override var reuseIdentifier: String? {
        CardCollectionViewCell.identifier
    }
    
    private let cornerRadius: CGFloat = 8
    
    // MARK: - Views
    private var contentClipper: UIView!
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }
    
    private func initialization() {
        self.contentClipper = UIView(frame: .zero)
        self.imageView = UIImageView(frame: .zero)
        self.titleLabel = UILabel(frame: .zero)
        self.subtitleLabel = UILabel(frame: .zero)
        
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.clipsToBounds = false
        self.contentView.layer.shadowColor = UIColor.cardSubtitle.cgColor
        self.contentView.layer.shadowRadius = 3
        self.contentView.layer.shadowOpacity = 0.2
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.contentView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.contentView.backgroundColor = .white
        
        self.contentClipper.layer.cornerRadius = cornerRadius
        self.contentClipper.clipsToBounds = true
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        self.titleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        self.titleLabel.textColor = .cardTitle
        self.titleLabel.numberOfLines = 1
        
        self.subtitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        self.subtitleLabel.textColor = .cardSubtitle
        self.subtitleLabel.numberOfLines = 2
        
        self.contentView.addSubview(self.contentClipper)
        self.contentClipper.addSubviews(imageView, titleLabel, subtitleLabel)
        
        self.createConstraints()
    }
    
    private func createConstraints() {
        self.contentClipper.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading)
            make.top.equalTo(self.contentView.snp.top)
            make.trailing.equalTo(self.contentView.snp.trailing)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.contentClipper)
            make.top.equalTo(self.contentClipper)
            make.trailing.equalTo(self.contentClipper)
            make.height.equalTo(self.contentClipper.snp.height).dividedBy(1.5)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentClipper.snp.leading).offset(12)
            make.trailing.equalTo(self.contentClipper.snp.trailing).offset(-12)
            make.top.equalTo(self.imageView.snp.bottom).offset(12)
        }

        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.equalTo(self.contentClipper).offset(12)
            make.trailing.equalTo(self.contentClipper).offset(-12)
        }
    }
    
    func setData(_ data: Data) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        
        guard let url = URL(string: data.imageUrl) else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: #imageLiteral(resourceName: "tab_character_inactive"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
        ])
    }
}
