import Foundation

class JSONParser {
    let decoder = JSONDecoder()
    
    func mapObject<T: Decodable>(_ type: T.Type, data: Data) -> T {
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(type, from: data)
            return result
        } catch let error{
            print("Decoding error: \(error)")
        }
        fatalError("Error maping")
    }
}
