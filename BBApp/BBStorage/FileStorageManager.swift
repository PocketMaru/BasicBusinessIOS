//
//  FileStorageManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation

struct FileStorageManager {
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func fileURL(for filename: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(filename)
    }
}

extension FileStorageManager: CustomerListStorageManager, QuoteListStorageManeger {
    func saveCustomers(_ customers: [CustomerModel]) throws {
        let data = try JSONEncoder().encode(customers)
        try data.write(to: FileStorageManager.fileURL(for: "customers.json"), options: [.atomic, .completeFileProtection])
    }
    
    func loadCustomers() throws -> [CustomerModel] {
        let data = try Data(contentsOf: FileStorageManager.fileURL(for: "customers.json"))
        return try JSONDecoder().decode([CustomerModel].self, from: data)
    }
    
    func saveQuotes(_ quotes: [QuoteModel]) throws {
        let data = try JSONEncoder().encode(quotes)
        try data.write(to: FileStorageManager.fileURL(for: "quotes.json"), options: [.atomic, .completeFileProtection])
    }
    
    func loadQuotes() throws -> [QuoteModel] {
        let data = try Data(contentsOf:
            FileStorageManager.fileURL(for: "quotes.json"))
        return try JSONDecoder().decode([QuoteModel].self, from: data)
    }
}


