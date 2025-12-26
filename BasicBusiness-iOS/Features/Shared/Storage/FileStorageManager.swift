import Foundation

enum FileStorageManager {
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
    }
    
    static func fileURL(for filename: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(filename)
    }
    
    static func save<T: Codable>(
        _ items: [T],
        as filename: String
    ) throws {
        let url = fileURL(for: filename)
        let data = try JSONEncoder().encode(items)
        try data.write(
            to: url,
            options: [.atomic, .completeFileProtection]
        )
    }
    
    static func load<T: Codable>(
        from filename: String
    ) throws -> [T] {
        let url = fileURL(for: filename)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([T].self, from: data)
    }
}
