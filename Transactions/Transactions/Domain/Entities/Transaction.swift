import Foundation
import SwiftUI

// MARK: - Domain Entity
// Pure Swift — no Codable, no networking, no persistence dependencies.
// Both the Data and Presentation layers depend on this type; it depends on nothing.
// Codable concerns live in TransactionDTO (Data layer).

struct TransactionAmount: Equatable {
    let value: String
    let currency: String
}

struct Transaction: Identifiable, Equatable {
    let id: String
    let counterpartyName: String
    let amount: TransactionAmount
    let emittedAt: Date
    let status: TransactionStatus
    let note: String?
}

enum TransactionStatus: String {
    case completed = "COMPLETED"
    case pending   = "PENDING"
    case declined  = "DECLINED"
}

extension Transaction {
    var formattedAmount: String {
        guard let value = Double(amount.value) else { return amount.value }
        return String(format: "%.2f %@", value, amount.currency)
    }
}

extension TransactionStatus {
    var displayName: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .completed: return .green
        case .pending:   return .orange
        case .declined:  return .red
        }
    }
}
