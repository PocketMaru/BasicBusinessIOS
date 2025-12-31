import Foundation

struct CustomField: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var label: String
    var value: Double?
}

extension CustomField {
    static func make() -> CustomField {
        return CustomField(
            label: "",
            value: nil
        )
    }
}
