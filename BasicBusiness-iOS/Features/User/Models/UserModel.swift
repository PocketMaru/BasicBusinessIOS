import Foundation

struct UserModel: Identifiable, Codable, Hashable, Equatable {

    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var businessName: String = "Business Name"
    var industryType: IndustryType
    var profileImageData: Data?
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

extension UserModel {
    static let sample = UserModel(
        firstName: "Joshua",
        lastName: "Hauer",
        businessName: "Basic Business",
        industryType: .landscaping(.empty),
        profileImageData: nil
    )
}
