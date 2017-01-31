import Foundation
import UIKit

//------------Cell Builder-------------

extension Game {
    
    //--------------------Cell of First UITableView -------------------//
    func getCellForTableViewController(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GameCellTableViewCell
        
        cell.backgroundColor = ColorUI.background
        cell.name?.textColor = ColorUI.text
        cell.company?.textColor = ColorUI.text
        cell.years?.textColor = ColorUI.text

        cell.cover?.layer.cornerRadius = 30.0
        cell.cover?.clipsToBounds = true
        
        cell.name?.text = name
        nameCompanyDB(id: developers?.first, callback: { nameCompany in
            cell.company?.text = nameCompany
        })
        cell.years?.text = releaseDate?.first?.year.map(String.init)
        let placeholder = #imageLiteral(resourceName: "img-not-found")
        if let urlExist = getUrlHttps(url: cover?.url) {
            cell.cover?.af_setImage(
                withURL: urlExist,
                placeholderImage: placeholder,
                runImageTransitionIfCached: true)
        } else {
            cell.cover?.image = placeholder
        }
        return cell
    }
    
    //--------------------Cell of Description UITableView -------------------//
    var gameDescriptionFields: [(UITableView,IndexPath) -> UITableViewCell] {
        return [
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellSummary(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellCover(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellCompany(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellPublished(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellPlatform(tableView: tableView, indexPath: indexPath)
            },
            { (tableView,indexPath) -> UITableViewCell in
                self.getCellRate(tableView: tableView, indexPath: indexPath)
            }
        ]
    }
    
    func getCellCover(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoverTableViewCell.coverTableViewCellIdentifier, for: indexPath) as! CoverTableViewCell
        let placeholder = #imageLiteral(resourceName: "img-not-found")
        
        cell.thumbnail?.layer.cornerRadius = 30.0

        if let urlExist = getUrlHttps(url: cover?.url) {
            cell.thumbnail?.af_setImage(
                withURL: urlExist,
                placeholderImage: placeholder,
                imageTransition: .crossDissolve(0.2),
                runImageTransitionIfCached: true)
            
        } else {
            cell.thumbnail?.image = placeholder
        }
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    func getCellSummary(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.summaryTableViewCellIdentifier, for: indexPath) as! SummaryTableViewCell
        
        cell.backgroundColor = ColorUI.background
        cell.isSelected = false
        cell.summaryText?.textColor = ColorUI.text
        cell.layer.cornerRadius = 20
        cell.summaryText?.text = summary
        return cell
    }
    func getCellCompany(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.companyTableViewCellIdentifier, for: indexPath) as! CompanyTableViewCell
        
        cell.backgroundColor = ColorUI.background
        cell.company?.textColor = ColorUI.text
        cell.layer.cornerRadius = 20

        if let id = developers?.first {
            if let nameCompany = fetchCompany(id: Int32(id)) {
                cell.company?.text = nameCompany
            } else {
                cell.company?.text = "N.D."
            }
        } else {
            cell.company?.text = "N.D."
        }
        return cell
        }
    
        func getCellPublished(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: PublishedTableViewCell.publishedTableViewCellIdentifier, for: indexPath) as! PublishedTableViewCell
           
            cell.backgroundColor = ColorUI.background
            cell.firstReleaseDate?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20

            cell.firstReleaseDate?.text = releaseDate?.first?.year.map(String.init)
            return cell
        }
    
        func getCellPlatform(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlatformTableViewCell.platformTableViewCellIdentifier, for: indexPath) as! PlatformTableViewCell
            
            cell.backgroundColor = ColorUI.background
            cell.platform?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20

            namePlatformDB(id: releaseDate?.first?.platform, callback: { namePlatform in
                cell.platform?.text = namePlatform
            })
            return cell
        }
    
        func getCellRate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: RatingTableViewCell.ratingTableViewCellIdentifier, for: indexPath) as! RatingTableViewCell
            
            cell.backgroundColor = ColorUI.background
            cell.rate?.textColor = ColorUI.text
            cell.layer.cornerRadius = 20

            cell.rate?.text = rating.map(String.init) ?? "N.D."
            return cell
        }
        
        func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, game: Game) {
            navigationController.pushViewController(GameDescriptionTableViewController(game: game), animated: true)
        }
        
        func didSelectGame(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController, url: String) {
            switch indexPath.row {
            case 1:
                navigationController.navigationBar.isTranslucent = false
                navigationController.pushViewController(CoverViewController(coverURL: cover?.url), animated: true)
            default:
                return
            }
        }
    }
    
    
    func heightRowInGameDescription(indexPath: Int) -> CGFloat {
        switch indexPath {
        case 0:
            return 170
        case 1:
            return 90
        case 2:
            return 60
        case 3:
            return 60
        case 4:
            return 60
        case 5:
            return 60
        default:
            return 0
        }
}

