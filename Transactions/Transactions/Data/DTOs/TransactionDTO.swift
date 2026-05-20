import Foundation

struct TransactionDTO: Codable {
    let id: String
    let counterpartyName: String
    let amount: AmountDTO
    let emittedAt: Date
    let status: String
    let note: String

    struct AmountDTO: Codable {
        let value: String
        let currency: String
    }
}

extension TransactionDTO {
    func toDomain() -> Transaction? {
        guard let status = TransactionStatus(rawValue: status) else { return nil }
        return Transaction(
            id: id,
            counterpartyName: counterpartyName,
            amount: TransactionAmount(value: amount.value, currency: amount.currency),
            emittedAt: emittedAt,
            status: status,
            note: note
        )
    }
}
