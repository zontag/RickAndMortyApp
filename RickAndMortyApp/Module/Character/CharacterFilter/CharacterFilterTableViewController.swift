import UIKit
import ReactiveSwift
import ReactiveCocoa

protocol CharacterFilterTableViewControllerDelegate: AnyObject {
    func goSearchForName()
    func goSearchForSpecies()
}

class CharacterFilterTableViewController: UITableViewController {
    
    enum FilterType {
        case name
        case species
        case status
        case gender
        case unknown
    }
    
    private let (lifetime, token) = Lifetime.make()
    private var store: Store<CharacterState, CharacterAction>!
    private var filter: CharacterFilterState! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    weak var delegate: CharacterFilterTableViewControllerDelegate?
    
    convenience init(store: Store<CharacterState, CharacterAction>) {
        self.init(style: .grouped)
        self.store = store
        self.filter = store.state.value.filter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(
            ToggleTableViewCell.self,
            forCellReuseIdentifier: ToggleTableViewCell.defaultReuseIdentifier)
        self.tableView.register(
            ToggleTableViewCell.self,
            forCellReuseIdentifier: ToggleTableViewCell.subtitleReuseIdentifier)
        self.tableView.contentInset = UIEdgeInsets(top: 73, left: 46, bottom: 0, right: -46)
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 46, bottom: 0, right: 0)
        self.tableView.separatorInsetReference = .fromAutomaticInsets
        self.tableView.allowsMultipleSelection = false
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.createRounded(
            title: "APPLY",
            target: self,
            action: #selector(applyAction))
        
        store.state.producer
            .take(during: lifetime)
            .map(\.filter)
            .observe(on: UIScheduler())
            .startWithValues(applyFilter)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func applyFilter(_ filter: CharacterFilterState) {
        self.filter = filter
    }
    
    // MARK: - Action
    @objc private func applyAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            switch section {
            case 0, 1:
                return 1
            case 2:
                return 3
            case 3:
                return 4
            default:
                return 0
            }
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let section = indexPath.section
            let row = indexPath.row
            
            let identifier = section > 1
                ? ToggleTableViewCell.defaultReuseIdentifier
                : ToggleTableViewCell.subtitleReuseIdentifier
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identifier,
                for: indexPath) as! ToggleTableViewCell
            
            var cellTitle = section == 0 ? "Name"
                : section == 1 ? "Species"
                : ""
            
            var state = false
            
            switch filterTypeFor(indexPath) {
            case .name:
                state = !self.filter.name.isEmpty
                cell.detailTextLabel?.text = self.filter.name.isEmpty ? "Give a name" : self.filter.name
            case .species:
                state = !self.filter.species.isEmpty
                cell.detailTextLabel?.text = self.filter.species.isEmpty ? "Select one" : self.filter.species
            case .status:
                cellTitle
                    = row == 0 ? "Alive"
                    : row == 1 ? "Dead"
                    : row == 2 ? "Unknown" : ""
                
                state
                    = row == 0 ? filter.status == .alive
                    : row == 1 ? filter.status == .dead
                    : filter.status == .unknown
            case .gender:
                cellTitle
                    = row == 0 ? "Female"
                    : row == 1 ? "Male"
                    : row == 2 ? "Genderless"
                    : row == 3 ? "Unknown"
                    : ""
                
                state
                    = row == 0 ? filter.gender == .female
                    : row == 1 ? filter.gender == .male
                    : row == 2 ? filter.gender == .genderless
                    : filter.gender == .unknown
            default:
                break
            }
            
            cell.textLabel?.text = cellTitle
            cell.state = state ? .on : .off
            
            return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int)
        -> CGFloat {
            return section > 1 ? 47 : 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int)
        -> UIView? {
            let view = FilterHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 47))
            let title = section == 2 ? "Status"
                : section == 3 ? "Gender"
                : ""
            view.setTitle(title)
            return view
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let cell = tableView.cellForRow(at: indexPath) as? ToggleTableViewCell, cell.state == .on {
            switch filterTypeFor(indexPath) {
            case .name:
                self.store.send(.setFilter(.name(String.empty)))
            case .species:
                self.store.send(.setFilter(.species(String.empty)))
            case .status:
                self.store.send(.setFilter(.status(.none)))
            case .gender:
                self.store.send(.setFilter(.gender(.none)))
            case .unknown:
                break
            }
            return
        }
        
        switch filterTypeFor(indexPath) {
        case .name:
            delegate?.goSearchForName()
        case .species:
            delegate?.goSearchForSpecies()
        case .status:
            let status: CharacterFilterState.Status
                = indexPath.row == 0 ? .alive
                    : indexPath.row == 1 ? .dead
                    : .unknown
            self.store.send(.setFilter(.status(status)))
        case .gender:
            let gender: CharacterFilterState.Gender
                = indexPath.row == 0 ? .female
                    : indexPath.row == 1 ? .male
                    : indexPath.row == 2 ? .genderless
                    : .unknown
            self.store.send(.setFilter(.gender(gender)))
        default:
            break
        }
    }
    
    private func filterTypeFor(_ indexPath: IndexPath) -> FilterType {
        switch indexPath.section {
        case 0:
            return .name
        case 1:
            return .species
        case 2:
            return .status
        case 3:
            return .gender
        default:
            return .unknown
        }
    }
}
