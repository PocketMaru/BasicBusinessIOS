import Foundation

struct CustomFieldModel: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var label: String
    var value: Double?
}

extension CustomFieldModel {
    static func make() -> CustomFieldModel {
        return CustomFieldModel(
            label: "",
            value: nil
        )
    }
}
