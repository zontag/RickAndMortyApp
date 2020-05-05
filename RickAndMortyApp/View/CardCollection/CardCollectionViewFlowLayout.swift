import UIKit

class CardCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var itemsPerRow: CGFloat = 2
    
    var sectionInsets = UIEdgeInsets(top: 16.0,
                                     left: 16.0,
                                     bottom: 16.0,
                                     right: 16.0)
    
    override var itemSize: CGSize {
        get {
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = (collectionView?.frame.width ?? .zero) - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: widthPerItem * 1.25)
        }
        set {
            fatalError("❌ CardCollectionViewFlowLayout: Please, dont set any value for itemSize.")
        }
    }
    
    override init() {
        super.init()
        self.minimumLineSpacing = 16
        self.minimumInteritemSpacing = 0
        self.sectionInset = sectionInsets
    }
    
    required init?(coder: NSCoder) {
        fatalError("❌ What the fuck are you doing?!")
    }
}
