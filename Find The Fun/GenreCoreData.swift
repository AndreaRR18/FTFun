import Foundation
import UIKit
import CoreData

class GenreCoreData {
    
    static func saveGenre(idGenre: Int32, nameGenre: String) {
        
        let context = DatabaseController.persistentContainer.viewContext
        let newGenre = NSEntityDescription.insertNewObject(forEntityName: "GenreData", into: context)
        
        newGenre.setValue(idGenre, forKey: "idGenre")
        newGenre.setValue(nameGenre, forKey: "nameGenre")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchGenre(id: Int32) -> String? {
        
        let context = DatabaseController.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GenreData")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if id == result.value(forKey: "idGenre") as? Int32 {
                    return result.value(forKey: "nameGenre") as? String
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    static func nameGenreDB(id: [Int], callback:@escaping (() throws -> (String)) -> ()) {
        var genres: [String] = []
        
        id.forEach{ idGenre in
            if let nameGenre = GenreCoreData.fetchGenre(id: Int32(idGenre)) {
                genres.append(nameGenre)
            } else {
                let decodeJSON = DecodeJSON(url: GetUrl.getUrlIDGenre(idGenre: idGenre))
                
                decodeJSON.getGenres(callback: { getGenre in
                    do {
                        let arrayGenres = try getGenre()
                        arrayGenres.forEach({
                            genres.append( $0.nameGenre )
                            saveGenre(idGenre: Int32($0.idGenre), nameGenre: $0.nameGenre)
                        })
                    } catch let error {
                        callback { throw error }
                    }
                })
            }
        }
        callback { genres.joined(separator: ", ") }
    }
    
}
