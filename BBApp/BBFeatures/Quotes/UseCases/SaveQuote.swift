import Foundation

protocol SaveQuoteUseCase {
    
    func create(
        draft: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel]
    
    func update(
        quote: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel]
    
    func delete(
        quote: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel]
}

final class SaveQuote: SaveQuoteUseCase {
    private let fileStorage: FileStorageManager
    private let filename = "quotes.json"
    
    init(fileStorage: FileStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func create(
        draft: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel] {
        if currentList.contains(where: { $0.id == draft.id }) {
            throw SaveError.writeFailed(reason: "Duplicate Quote ID")
        }
        var updatedList = currentList + [draft]
        try fileStorage.save(updatedList, as: filename)
        return updatedList
    }
    
    func update(
        quote: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel] {
        var snapShot = currentList
        guard let index = snapShot.firstIndex(where: {$0.id == quote.id})
        else {
            throw SaveError.writeFailed(reason: "Quote Not Found")
        }
        snapShot[index] = quote
        try fileStorage.save(snapShot, as: filename)
        return snapShot
    }
    
    func delete(
        quote: QuoteModel,
        currentList: [QuoteModel]
    ) throws -> [QuoteModel] {
        var updatedList = currentList
        guard let index = updatedList.firstIndex(where: {$0.id == quote.id}) else {
            throw SaveError.writeFailed(reason: "Quote not found")
        }
        updatedList.remove(at: index)
        try fileStorage.save(updatedList, as: filename)
        return updatedList
    }
}
