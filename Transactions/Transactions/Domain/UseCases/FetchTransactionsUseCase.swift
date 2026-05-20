import Foundation

protocol FetchTransactionsUseCaseProtocol {
    func execute() async throws -> [Transaction]
}

final class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    private let repository: TransactionRepositoryProtocol

    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Transaction] {
        try await repository.fetchTransactions()
    }
}
