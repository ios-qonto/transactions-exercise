import Foundation
@testable import Transactions

final class MockHTTPClient: HTTPClientProtocol {
    private let data: Data
    var error: Error?

    init(data: Data) {
        self.data = data
    }

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        if let error { throw error }
        return try JSONDecoder.apiDecoder.decode(T.self, from: data)
    }
}

extension MockHTTPClient {
    static func fromFixture(named name: String) throws -> MockHTTPClient {
        let url = Bundle(for: MockHTTPClient.self)
            .url(forResource: name, withExtension: "json")!
        return MockHTTPClient(data: try Data(contentsOf: url))
    }
}
