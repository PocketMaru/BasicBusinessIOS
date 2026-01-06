import Foundation

enum ConversionError: Error {
    case writeFailed(reason: String)
    var message: String {
        switch self {
        case .writeFailed(let reason):
            return "Failed to convert model: \(reason)"
        }
    }
}
