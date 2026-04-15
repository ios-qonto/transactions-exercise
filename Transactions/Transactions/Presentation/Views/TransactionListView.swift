import SwiftUI

struct TransactionListView: View {
    @State private var viewModel = TransactionListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.transactions) { transaction in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(transaction.counterpartyName)
                                    .font(.body)
                                Text(transaction.emittedAt.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(transaction.formattedAmount)
                                    .font(.body)
                                    .fontWeight(.medium)
                                Text(transaction.status.displayName)
                                    .font(.caption)
                                    .foregroundStyle(transaction.status.color)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Transactions")
        }
        .task {
            await viewModel.loadTransactions()
        }
    }
}
