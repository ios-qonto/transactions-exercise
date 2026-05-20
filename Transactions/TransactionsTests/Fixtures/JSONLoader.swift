import Foundation
@testable import Transactions

enum JSONLoaderError: Error {
    case missingFile(String)
}

final class JSONLoader {
    static func load<T: Decodable>(from name: String) async throws -> T {
        guard let url = Bundle(for: JSONLoader.self).url(forResource: name, withExtension: "json") else {
            throw JSONLoaderError.missingFile(name)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder.apiDecoder.decode(T.self, from: data)
    }
}
