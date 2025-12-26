enum ServiceType: Equatable, Codable, Hashable {
    case installation
    case maintenance
    case repair
    case recurring
    case custom(String)
    case none
    var name: String {
        switch self {
        case .installation:
            return "Installation"
        case .maintenance:
            return "Maintenance"
        case .repair:
            return "Repair"
        case .recurring:
            return "Recurring"
        case .custom(let name):
            return name
        case .none:
            return "None"
        }
    }
}
struct ServiceChoice: Identifiable, Hashable {
    let id: String
    let displayName: String
    let type: ServiceType
}

extension ServiceChoice {
    static let all: [ServiceChoice] = [
        .init(id: "installation", displayName: "Installation", type: .installation),
        .init(id: "maintenance", displayName: "Maintenance", type: .maintenance),
        .init(id: "repair", displayName: "Repair", type: .repair),
        .init(id: "recurring", displayName: "Recurring", type: .recurring),
        .init(id: "none", displayName: "None", type: .none)
    ]
}
