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

struct IndustryChoice: Identifiable, Hashable {
    let id: String
    let displayName: String
    let type: IndustryType
    
    static let all: [IndustryChoice] = [
        IndustryChoice(id: "landscaping", displayName: "Landscaping", type: .landscaping(.empty)),
        IndustryChoice(id: "pressureWashing", displayName: "Pressure Washing", type: .pressureWashing(.empty)),
        IndustryChoice(id: "consulting", displayName: "Consulting", type: .consulting(.empty)),
        IndustryChoice(id: "handyman", displayName: "Handyman", type: .handyman(.empty)),
        IndustryChoice(id: "HVAC", displayName: "HVAC", type: .HVAC(.empty)),
        IndustryChoice(id: "productSales", displayName: "Product Sales", type: .productSales(.empty)),
        IndustryChoice(id: "none", displayName: "None", type: .none)
    ]
    
    static func == (lhs: IndustryChoice, rhs: IndustryChoice) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
