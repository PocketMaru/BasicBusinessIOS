//
//  BBFileManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/29/25.
//

import Foundation

enum FileStorage {
    static func fileURL(for filename: String) -> URL {
        getDocumentsDirectory().appendingPathComponent(filename)
    }
    static var customerFileURL: URL {
        fileURL(for: "customers.json")
    }
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
