import Foundation
import UIKit
import CoreData

class CompanyCoreData {
    
static func saveCompany(idCompany: Int32, nameCompany: String) {
    let context = DatabaseController.persistentContainer.viewContext
    let newCompany = NSEntityDescription.insertNewObject(forEntityName: "CompanyData", into: context)
    newCompany.setValue(idCompany, forKey: "idCompany")
    newCompany.setValue(nameCompany, forKey: "nameCompany")
    do {
        try context.save()
        print("Save \(nameCompany)")
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

static func fetchCompany(id: Int32) -> String? {
    let context = DatabaseController.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CompanyData")
    request.returnsObjectsAsFaults = false
    do {
        let results = try context.fetch(request)
        for result in results as! [NSManagedObject] {
            if id == result.value(forKey: "idCompany") as! Int32 {
                return result.value(forKey: "nameCompany") as? String
            }
        }
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return nil
}

static func companyDB(id: Int, callback: @escaping (() throws -> (String, Bool)) -> ()) {
    var new = true
    if let nameCompany = CompanyCoreData.fetchCompany(id: Int32(id)) {
        new = false
        callback { (nameCompany, new) }
    } else {
        let decodeJSON = DecodeJSON(url: GetUrl.getUrlIDCompany(idCompany: id))
        decodeJSON.getCompany(callback: { getCompany in
            
            do {
                let company = try getCompany()
                callback { (company.name, new) }
                CompanyCoreData.saveCompany(idCompany: Int32(company.idCompany), nameCompany: company.name)
            } catch let error {
                callback { throw error }
            }
            
        })
    }
}

}

