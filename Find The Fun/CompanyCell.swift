import Foundation
import UIKit

class CompanyCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}

class PublisherCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}

class DeveloperCell: CellFactory {
    
    private let company: Int
    
    init(_ company: Int) {
        self.company = company
    }
    func didSelectCell(tableView: UITableView, indexPath: IndexPath, navigationController: UINavigationController) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.companyTableViewCell, for: indexPath) as! CompanyTableViewCell
        companyDB(id: company, callback: { nameCompany, new in
            cell.configureCompanyTableViewCell(nameCompany)
            if new {
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                    tableView.reloadData()
                })
            }
        })
        return cell
    }
}



