import Runes
import Argo
import Curry

struct Company {
    let idCompany: Int //id
    let name: String //name
}

extension Company: Decodable {
    static func decode(_ json: JSON) -> Decoded<Company> {
        return curry(Company.init)
            <^> json <| "id"
            <*> json <| "name"
    }
}

