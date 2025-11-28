enum LaborType: Codable, Equatable, Hashable {
    case hourly(rate: Double, hours: Double)
    case flatRate(Double)
    case none
    
    func calculateTotal() -> Double {
        switch self {
        case .hourly(let rate, let hours):
            return rate * hours
        case .flatRate(let flat):
            return flat
        case .none:
            return 0.0
        }
    }
}
