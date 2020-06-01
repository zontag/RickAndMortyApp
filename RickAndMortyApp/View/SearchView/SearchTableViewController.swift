import UIKit
import ReactiveCocoa
import ReactiveSwift

class SearchTableViewController: UITableViewController {
    private let (lifeTime, token) = Lifetime.make()
    private let searchController = UISearchController(searchResultsController: nil)
    private var values: [String] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var valuesProvider: Signal<[String], Never>!

    var inputValue = MutableProperty<String>("")
    
    convenience init(valuesProvider: Signal<[String], Never>) {
        self.init()
        valuesProvider
            .take(during: lifeTime)
            .observe(on: UIScheduler())
            .observeValues { values in
                self.values = values
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search"
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.values[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchController.searchBar.text = values[indexPath.row]
    }
}

// MARK: - UISearchResultsUpdating
extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        inputValue.value = searchController.searchBar.text?.lowercased() ?? ""
    }
}
