import Foundation

protocol TransactionRepositoryProtocol {
    func fetchTransactions() async throws -> [Transaction]
}
