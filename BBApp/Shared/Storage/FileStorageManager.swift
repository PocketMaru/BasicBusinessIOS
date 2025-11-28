//
//  FileStorageManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation

final class FileStorageManager {
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func fileURL(for filename: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(filename)
    }
}

extension FileStorageManager {
    func save<T: Codable>(_ items: [T], as filename: String) throws {
        let url = FileStorageManager.fileURL(for: filename)
        let data = try JSONEncoder().encode(items)
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
    
    func load<T: Codable>(from filename: String) throws -> [T] {
        let url = FileStorageManager.fileURL(for: filename)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([T].self, from: data)
    }
}


