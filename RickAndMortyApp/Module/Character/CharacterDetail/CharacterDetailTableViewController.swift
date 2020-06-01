import UIKit

class CharacterDetailTableViewController: UITableViewController {
    
    private var character: Character!
    
    convenience init(character: Character) {
        self.init(style: .grouped)
        self.character = character
        self.title = character.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.tableView.register(
            InfoTableViewCell.self,
            forCellReuseIdentifier: InfoTableViewCell.identifier)
        self.tableView.register(
            CharacterDetailHeaderTableViewCell.self,
            forCellReuseIdentifier: CharacterDetailHeaderTableViewCell.identifier)
        //        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorInsetReference = .fromAutomaticInsets
        self.tableView.allowsMultipleSelection = false
        self.clearsSelectionOnViewWillAppear = true
        self.clearsSelectionOnViewWillAppear = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return 4
        }
        
        if section == 2 {
            return character.episode.count
        }
        
        return 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let section = indexPath.section
            let row = indexPath.row
            
            if section == 0 {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: CharacterDetailHeaderTableViewCell.identifier,
                    for: indexPath) as! CharacterDetailHeaderTableViewCell
                
                cell.name = character.name
                cell.status = character.status
                cell.specie = character.species
                cell.characterImageUrl = character.image
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: InfoTableViewCell.identifier,
                for: indexPath) as! InfoTableViewCell
            
            var title: String = ""
            var subtitle: String = ""
            var detail: String? = nil
            
            if section == 1 {
                title
                    = row == 0 ? "Gender"
                    : row == 1 ? "Origin"
                    : row == 2 ? "Type"
                    : "Location"
                
                subtitle
                    = row == 0 ? character.gender
                    : row == 1 ? character.origin.name
                    : row == 2 ? character.type
                    : character.location.name
            }
            
            if section == 2 {
                title = "S\(row)E"
                subtitle = "Episode title"
                detail = character.episode[row]
            }
            
            cell.title = title
            cell.subtitle = subtitle
            cell.detail = detail
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension
            : indexPath.section == 1 ? 60 : 77
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 55))
        let title = section == 1 ? "Informations"
            : section == 2 ? "Episodes"
            : ""
        view.setTitle(title)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 55
    }
    
}
