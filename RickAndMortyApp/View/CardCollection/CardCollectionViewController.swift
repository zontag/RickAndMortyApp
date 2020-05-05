import UIKit



class CardCollectionViewController: UICollectionViewController, Injectable {
    
    // MARK: - State
    struct State {
        let isLoading: Bool
        let items: [CardCollectionViewCell.Data]
        let page: Int
        let pages: Int
        let errorMessage: String?
    }

    // MARK: - Actions
    enum Action {
        case pageUp
        case getData(page: Int)
        case setData(_ data: [CardCollectionViewCell.Data], pages: Int)
        case showError(String)
    }
    
    private var store: Store<State, Action>!
    
    convenience init(reducer: Reducer<CardCollectionViewController.State, CardCollectionViewController.Action>) {
        self.init(collectionViewLayout: CardCollectionViewFlowLayout())
        self.store = Store(
            initialState: State(
                isLoading: false,
                items: [],
                page: 0,
                pages: 0,
                errorMessage: nil),
            reducer: reducer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.prefetchDataSource = self
        self.collectionView.backgroundColor = .white
        self.collectionView.register(
            CardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        self.collectionView.dataSource = self
        store.state.signal.observeValues { value in
            if value.errorMessage != nil {
                let alert = UIAlertController(title: "OMG!", message: value.errorMessage, preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
                    let page = self.store.state.value.page
                    self.store.send(.getData(page: page))
                })
                alert.addAction(retryAction)
                self.present(alert, animated: true, completion: nil)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.store.send(.pageUp)
    }
}

// MARK: - UICollectionViewDataSource
extension CardCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return store.state.value.items.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier,
                                     for: indexPath) as! CardCollectionViewCell
            cell.setData(store.state.value.items[indexPath.row])
            return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension CardCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]) {
        debugPrint(indexPaths)
        
        guard !self.store.state.value.isLoading,
            self.store.state.value.page < self.store.state.value.pages,
            indexPaths.last?.row == self.store.state.value.items.count - 1
            else {
                return
        }
        
        self.store.send(.pageUp)
    }
}
