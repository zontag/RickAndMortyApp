import UIKit
import ReactiveCocoa
import ReactiveSwift

class CardCollectionViewController: UICollectionViewController {
    
    private var itemsSignal: Signal<[CardCollectionViewCell.Data], Never>!
    private var items: [CardCollectionViewCell.Data] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var onPrefetchItemsAt = MutableProperty<[IndexPath]>([])
    
    convenience init(itemsSignal: Signal<[CardCollectionViewCell.Data], Never>) {
        self.init(collectionViewLayout: CardCollectionViewFlowLayout())
        self.itemsSignal = itemsSignal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.prefetchDataSource = self
        self.collectionView.backgroundColor = .white
        self.collectionView.register(
            CardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        self.itemsSignal
            .observe(on: UIScheduler())
            .observeValues { values in
                self.items = values
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CardCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
        -> Int {
            return self.items.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier,
                                     for: indexPath) as! CardCollectionViewCell
            cell.setData(self.items[indexPath.row])
            return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension CardCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]) {
        self.onPrefetchItemsAt.value = indexPaths
    }
}
