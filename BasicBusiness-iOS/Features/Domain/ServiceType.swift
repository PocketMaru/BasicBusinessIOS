enum ServiceType: String, CaseIterable, Identifiable, Codable {
    case installation
    case maintenance
    case repair
    case recurring
    case custom
    case none
    
    var id: String { rawValue }
    
    var displayName: String {
            switch self {
            case .installation: return "Installation"
            case .maintenance: return "Maintenance"
            case .repair: return "Repair"
            case .recurring: return "Recurring"
            case .custom: return "Custom"
            case .none: return "None"
            }
        }
}
