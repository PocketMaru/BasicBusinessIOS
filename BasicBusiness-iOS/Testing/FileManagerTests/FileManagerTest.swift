@testable import BasicBusiness
import Testing
import Foundation

final class FileManagerTest {
    @Test
    func cacheBehavior() async throws {
        CustomerAPIManager.count = 0
        
        print("First fetch:")
        _ = try await CustomerManager.fetch()
        #expect(CustomerAPIManager.count == 1)
        
        print("\nSecond fetch (should use cache):")
        _ = try await CustomerManager.fetch()
        #expect(CustomerAPIManager.count == 1)
        
        print("\nWaiting for cache to expire...")
        try await Task.sleep(nanoseconds: 11_000_000_000)
        
        print("\nThird fetch (should hit API again):")
        _ = try await CustomerManager.fetch()
        #expect(CustomerAPIManager.count == 2)
    }
}

struct Customer: Codable {
    var name: String
    var email: String
    
    func mock() -> Self {
        .init(name: "New Name", email: "New Email")
    }
}

struct Cache<T> {
    var data: T
    var lastUpdated: Date
}

@MainActor
enum CustomerManager {
    private static var cache: Cache<[Customer]>?
    private static let ttl: TimeInterval = 10
    
    static func fetch() async throws -> [Customer] {
        if let cache, !isStale(cache.lastUpdated) {
            print("Using cache...")
            return cache.data
        }
        let fresh = try await CustomerAPIManager.fetchCustomers()
        
        cache = Cache(data: fresh, lastUpdated: Date())
        
        return fresh
    }
    
    private static func isStale(_ date: Date) -> Bool {
        let age = Date().timeIntervalSince(date)
        print("Age is \(age)")
        return age > ttl
    }
}

enum CustomerAPIManager {
    static var count = 0
    static func fetchCustomers() async throws -> [Customer] {
        count += 1
        try await Task.sleep(nanoseconds: 500_000_000) // simulate delay
        
        print("Fetching from API...")
        
        return [
            Customer(name: "Josh", email: "Josh@email.com"),
            Customer(name: "Kaley", email: "Kaley@email.com")
        ]
    }
}

