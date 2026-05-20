import Foundation

protocol HTTPClientProtocol {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}

final class URLSessionHTTPClient: HTTPClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        return try! JSONDecoder.apiDecoder.decode(T.self, from: data)
    }
}

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            guard let date = formatter.date(from: string) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid date: \(string)"
                )
            }
            return date
        }
        return decoder
    }
}
