//
//  SaveQuote.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 10/18/25.
//

import Foundation

protocol SaveQuoteUseCase {
    func create(from customer: CustomerModel, new draft: QuoteModel, currentList: [CustomerModel]) throws -> [CustomerModel]
    
    func edit(current customer: CustomerModel, new quote: QuoteModel, currentList: [CustomerModel]) throws -> [CustomerModel]
}

final class SaveQuote: SaveQuoteUseCase {
    private let fileStorage: CustomerListStorageManager
    
    init(fileStorage: CustomerListStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func create(from customer: CustomerModel,
                new draft: QuoteModel,
                currentList: [CustomerModel]) throws -> [CustomerModel] {
        var updated = currentList
        
        guard let index = updated.firstIndex(where: {$0.id == customer.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found.")
        }
        
        var modifiedCustomer = updated[index]
        modifiedCustomer.quotes = (modifiedCustomer.quotes ?? []) + [draft]
        updated[index] = modifiedCustomer
        try fileStorage.saveCustomers(updated)
        return updated
    }
    
    func edit(current customer: CustomerModel, new quote: QuoteModel, currentList: [CustomerModel]) throws -> [CustomerModel] {
        
        var snapShot = currentList
        
        guard let customerIndex = currentList.firstIndex(where: {$0.id == customer.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        
        var modifiedCustomer = snapShot[customerIndex]
        
        guard let quoteIndex = modifiedCustomer.quotes?.firstIndex(where: {$0.id == quote.id}) else {
            throw SaveError.writeFailed(reason: "Quote not found for this customer")
        }
        
        modifiedCustomer.quotes?[quoteIndex] = quote
        snapShot[customerIndex] = modifiedCustomer
        try fileStorage.saveCustomers(snapShot)
        return snapShot
    }
    
}
