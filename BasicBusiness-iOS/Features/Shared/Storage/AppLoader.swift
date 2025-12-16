import Foundation

struct AppLoader {
    let storage: FileStorageManager
    
    func load<T: Codable>(_ filename: String) -> [T] {
        do {
            return try storage.load(from: filename)
        } catch {
            return []
        }
    }
}
