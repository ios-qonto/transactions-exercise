import Foundation

private struct TransactionResponse: Decodable {
    let results: [TransactionDTO]
}

final class TransactionRepository: TransactionRepositoryProtocol {
    private let baseURL = URL(string: "https://us-central1-qonto-staging.cloudfunctions.net/transactions")!
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchTransactions() async throws -> [Transaction] {
        let response: TransactionResponse = try await httpClient.fetch(from: baseURL)
        return response.results.compactMap { $0.toDomain() }
    }
}
