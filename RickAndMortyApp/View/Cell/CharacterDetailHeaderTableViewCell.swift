import UIKit
import Kingfisher

class CharacterDetailHeaderTableViewCell: UITableViewCell {

    static let identifier = "CharacterDetailHeaderTableViewCell"
    
    private var vStack: UIStackView!
    private var innerVStack: UIStackView!
    private var backgroundImageView: UIImageView!
    private var characterImageView: UIImageView!
    private var statusLabel: UILabel!
    private var nameLabel: UILabel!
    private var specieLabel: UILabel!
    
    var characterImageUrl: String? {
        didSet {
            guard
                let urlString = characterImageUrl,
                let url = URL(string: urlString)
                else { return }
            characterImageView.kf.setImage(
                with: url,
                placeholder: #imageLiteral(resourceName: "tab_character_inactive"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }
    }
    
    var status: String? {
        didSet {
            self.statusLabel.text = self.status
        }
    }
    
    var name: String? {
        didSet {
            self.nameLabel.text = self.name
        }
    }
    
    var specie: String? {
        didSet {
            self.specieLabel.text = self.specie
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.vStack = UIStackView(frame: .zero)
        self.innerVStack = UIStackView(frame: .zero)
        self.characterImageView = UIImageView(frame: .zero)
        self.backgroundImageView = UIImageView(frame: .zero)
        self.statusLabel = UILabel(frame: .zero)
        self.nameLabel = UILabel(frame: .zero)
        self.specieLabel = UILabel(frame: .zero)
        
        self.vStack.axis = .vertical
        self.vStack.alignment = .center
        self.innerVStack.axis = .vertical
        self.innerVStack.alignment = .center
        
        self.statusLabel.numberOfLines = 1
        self.nameLabel.numberOfLines = 1
        self.specieLabel.numberOfLines = 1
        
        self.statusLabel.font = .systemFont(ofSize: 11, weight: .regular)
        self.nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        self.specieLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        self.statusLabel.textColor = .rowSubtitle
        self.nameLabel.textColor = .rowTitle
        self.specieLabel.textColor = .rowDescription
        
        self.characterImageView.layer.borderColor = UIColor.white.cgColor
        self.characterImageView.layer.borderWidth = 5
        self.characterImageView.clipsToBounds = true
        self.characterImageView.layer.cornerRadius = 65
        
        self.backgroundImageView.image = #imageLiteral(resourceName: "bg_header")
        self.backgroundImageView.contentMode = .scaleAspectFill
        
        self.characterImageView.kf.indicatorType = .activity
        self.backgroundColor = .backgroundGray
        self.selectionStyle = .none
        self.vStack.spacing = 20
        
        self.innerVStack.addArrangedSubview(self.statusLabel)
        self.innerVStack.addArrangedSubview(self.nameLabel)
        self.innerVStack.addArrangedSubview(self.specieLabel)
        self.vStack.addArrangedSubview(self.characterImageView)
        self.vStack.addArrangedSubview(self.innerVStack)
        self.contentView.addSubviews(self.backgroundImageView, self.vStack)
        
        self.backgroundImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.trailing.equalTo(self.contentView)
            make.height.equalTo(84)
        }
        
        self.characterImageView.snp.makeConstraints { make in
            make.height.equalTo(130)
            make.width.equalTo(130)
        }
        
        self.vStack.snp.makeConstraints { make in
            make.center.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(20)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("What the fuck are you doing?!")
    }
    
    
}
