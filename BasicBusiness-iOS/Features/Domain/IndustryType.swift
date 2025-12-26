enum IndustryType: Identifiable, Codable, Equatable, Hashable {
    /// Associated values for industry specific calculation
    case landscaping(LandscapeQM)
    case pressureWashing(PressureWashQM)
    case consulting(ConsultingQM)
    case handyman(HandymanQM)
    case HVAC(HVACQM)
    case productSales(ProductSalesQM)
    case none
    
    /// Raw value as ID for use in Picker or List
    var id: String {
        switch self {
        case .landscaping: return "landscaping"
        case .pressureWashing: return "pressureWashing"
        case .consulting: return "consulting"
        case .handyman: return "handyman"
        case .HVAC: return "HVAC"
        case .productSales: return "productSales"
        case .none: return "none"
        }
    }
    
    /// User-friendly string for each industry type
    var displayName: String {
        switch self {
        case .landscaping: return "Landscaping"
        case .pressureWashing: return "Pressure Washing"
        case .consulting: return "Consulting"
        case .handyman: return "Handyman"
        case .HVAC: return "HVAC"
        case .productSales: return "Product Sales"
        case .none: return "None"
        }
    }
    /// Return of total cost from each associated property
    var totalCost: Double {
        switch self {
        case .landscaping(let info): return info.totalCost
        case .pressureWashing(let info): return info.totalCost
        case .consulting(let info): return info.totalCost
        case .handyman(let info): return info.totalCost
        case .HVAC(let info): return info.totalCost
        case .productSales(let info): return info.totalCost
        case .none: return 0
        }
    }
}

extension IndustryType {
    var isNone: Bool {
        if case .none = self { return true }
        return false
    }
}

extension IndustryType {
    var pricingMethods: [PricingMethodModel] {
        switch self {
        case .landscaping(let qm): return qm.pricingMethods
        case .pressureWashing(let qm): return qm.pricingMethods
        case .consulting(let qm): return qm.pricingMethods
        case .handyman(let qm): return qm.pricingMethods
        case .HVAC(let qm): return qm.pricingMethods
        case .productSales(let qm): return qm.pricingMethods
        case .none: return []
        }
    }
}

struct IndustryChoice: Identifiable, Hashable {
    let id: String
    let displayName: String
    let type: IndustryType
}

extension IndustryChoice {
    static let all: [IndustryChoice] = [
        .init(id: "landscaping", displayName: "Landscaping", type: .landscaping(.empty)),
        .init(id: "pressureWashing", displayName: "Pressure Washing", type: .pressureWashing(.empty)),
        .init(id: "consulting", displayName: "Consulting", type: .consulting(.empty)),
        .init(id: "handyman", displayName: "Handyman", type: .handyman(.empty)),
        .init(id: "hvac", displayName: "HVAC", type: .HVAC(.empty)),
        .init(id: "productSales", displayName: "Product Sales", type: .productSales(.empty)),
        .init(id: "none", displayName: "None", type: .none)
    ]
}
