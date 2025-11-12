//
//  QuoteListStorageManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 10/19/25.
//

import Foundation

protocol QuoteListStorageManage {
    func saveQuotes(_ quotes: [QuoteModel]) throws
    func loadQuotes() throws -> [QuoteModel]
}
