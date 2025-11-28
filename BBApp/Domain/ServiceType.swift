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
