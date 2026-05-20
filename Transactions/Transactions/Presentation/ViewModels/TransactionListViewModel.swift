import Foundation
import Observation

@Observable
final class TransactionListViewModel {
    var transactions: [Transaction] = []
    var isLoading = false

    private let fetchTransactions = FetchTransactionsUseCase(repository: TransactionRepository())

    func loadTransactions() async {
        isLoading = true
        defer { isLoading = false }
        do {
            transactions = try await fetchTransactions.execute()
        } catch {
            print("Error: \(error)")
        }
    }
}
