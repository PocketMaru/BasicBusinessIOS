//
//  QuoteModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

// MARK: — Quoteable Protocol
/// Protocol `Quoteable` defines shared properties for all quote types

// MARK: — QuoteModel
/// Struct `QuoteModel` stores all details of a created quote and conforms to `Quoteable`

// MARK: — ServiceType
/// Enumeration `ServiceType` represents the category of work being preformed (e.g., Installation, Maintenance, etc.)

// MARK: — PricingMethod
/// Enumeration `PricingMethod` represents how the quote will be priced (e.g., Fixed Rate, Subscription, etc.)

// MARK: — QuoteModel + Sample
/// Adds sample data for previews and test cases

// Allows the sharing of optional fields from child quote models
struct CustomField: Codable, Hashable {
    let label: String
    let value: String
}
// TODO: Remove quoteModel and use children models independently
// TODO: Add toInvoice as a protocol
// TODO: Add CustomField to protocol with label and value for independent fields you can add,
// TODO: make it an array and iterate through it in the view to display more custom fields
/// This will allow consistent conversion from a quote to invoice, and back. 
struct QuoteModel: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var customer: CustomerModel
    var customerID: UUID {
        customer.id
    }
    var industryType: IndustryType
    var serviceType: ServiceType
    var pricingMethods: [PricingMethod]
    var quoteDate: Date = Date()
    var installationDate: Date?
    var serviceDate: Date?
    var notes: String?
    var subscriptionTotal: Double?
    var materialCost: Double?
    var laborCost: LaborType?
    var additionalFees: Double?
    var totalCost: Double {
        let materialCost = materialTotalCost ?? 0
        let laborCost = laborCost?.calculateTotal() ?? 0
        let customFieldCost = customFields.map { Double($0.value) ?? 0 }.reduce(0, +)
        let additionalFeesCost = additionalFees ?? 0
        let subscriptionTotalCost = subscriptionTotal ?? 0
        let pricingMethodTotal = pricingMethods.reduce(0) { $0 + $1.calculateTotal() }
        return materialCost + laborCost + customFieldCost + additionalFeesCost + subscriptionTotalCost + pricingMethodTotal
    }
    var customFields: [CustomField] = []
    var materialExpenses: [MaterialExpenseQM]? = nil
    var materialTotalCost: Double? {
        materialExpenses?.map(\.unitCost).reduce(0, +)
    }
    // Pending expenses, these are expenses tied to quotes, this allows the user to see what expenses will be when a job converts to invoice, allowing forecasting of future expenses from jobs.
    var pendingMaterialExpense: [MaterialExpensePreview] = []
}

extension QuoteModel {
    func toInvoice() -> InvoiceModel {
        return InvoiceModel(
            id: UUID(),
            customer: self.customer,
            industryType: self.industryType,
            serviceType: self.serviceType,
            pricingMethod: self.pricingMethods,
            invoiceDate: Date(),
            installationDate: self.installationDate,
            serviceDate: self.serviceDate,
            notes: self.notes,
            subscriptionTotal: self.subscriptionTotal,
            materialCost: self.materialCost,
            laborCost: self.laborCost,
            additionalFees: self.additionalFees,
            totalCost: self.totalCost,
            materialExpenses: self.materialExpenses
        )
    }
}

enum IndustryType: Identifiable, Codable, Equatable, Hashable {
    /// Associated values for industry specific calculation
    case landscaping(LandscapeQM)
    case pressureWashing(PressureWashQM)
    case consulting(ConsultingQM)
    case handyman(HandymanQM)
    case HVAC(HVACQM)
    case productSales(ProductSalesQM)
    case none
    
    /// Raw value as ID for use in Picker or List
    var id: String {
        switch self {
        case .landscaping: return "landscaping"
        case .pressureWashing: return "pressureWashing"
        case .consulting: return "consulting"
        case .handyman: return "handyman"
        case .HVAC: return "HVAC"
        case .productSales: return "productSales"
        case .none: return "none"
        }
    }
    
    /// User-friendly string for each industry type
    var displayName: String {
        switch self {
        case .landscaping: return "Landscaping"
        case .pressureWashing: return "Pressure Washing"
        case .consulting: return "Consulting"
        case .handyman: return "Handyman"
        case .HVAC: return "HVAC"
        case .productSales: return "Product Sales"
        case .none: return "None"
        }
    }
    /// Return of total cost from each associated property
    var totalCost: Double {
        switch self {
        case .landscaping(let info): return info.totalCost
        case .pressureWashing(let info): return info.totalCost
        case .consulting(let info): return info.totalCost
        case .handyman(let info): return info.totalCost
        case .HVAC(let info): return info.totalCost
        case .productSales(let info): return info.totalCost
        case .none: return 0
        }
    }
}

enum ServiceType: Equatable, Codable, Hashable {
    case installation
    case maintenance
    case repair
    case recurring
    case custom(String)
    case none
    var name: String {
        switch self {
        case .installation:
            return "Installation"
        case .maintenance:
            return "Maintenance"
        case .repair:
            return "Repair"
        case .recurring:
            return "Recurring"
        case .custom(let name):
            return name
        case .none:
            return "None"
        }
    }
}
// MARK: Wrapping PricingMethod with a UUID so it can be stored in an array
struct IdentifiedPricingMethod: Identifiable {
    var id = UUID()
    var pricingMethod: PricingMethod
}
extension IdentifiedPricingMethod {
    init(_ method: PricingMethod) {
        self.pricingMethod = method
    }
}

// MARK: Universal calculations
enum PricingMethod: Hashable, Codable {
    case fixedRate(Double)
    case squareFootage(amount: Double, rate: Double)
    case liquidSolution(amount: Double, rate: Double)
    case subscription(Double)
    case none
    
    func calculateTotal() -> Double {
        switch self {
        case .fixedRate(let fixed):
            return fixed
        case .squareFootage(let amount, let rate):
            return amount * rate
        case .liquidSolution(let amount, let rate):
            return amount * rate
        case .subscription(let sub):
            return sub
        case .none:
            return 0.0
        }
    }
}

enum LaborType: Codable, Equatable, Hashable {
    case hourly(rate: Double, hours: Double)
    case flatRate(Double)
    case none
    
    func calculateTotal() -> Double {
        switch self {
        case .hourly(let rate, let hours):
            return rate * hours
        case .flatRate(let flat):
            return flat
        case .none:
            return 0.0
        }
    }
}

extension QuoteModel {
    static let sample = QuoteModel(
        customer: .sample,
        industryType: .landscaping(.empty),
        serviceType: .installation,
        pricingMethods: [.fixedRate(0.0)],
        notes: "This is a sample quote."
    )
    
    static let sampleList: [QuoteModel] = [
        .sample,
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping(.empty),
            serviceType: .maintenance,
            pricingMethods: [.subscription(0.0)]
        ),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping(.empty),
            serviceType: .maintenance,
            pricingMethods: [.fixedRate(0.0)]
        ),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping(.empty),
            serviceType: .maintenance,
            pricingMethods: [.fixedRate(0.0)]
        ),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping(.empty),
            serviceType: .custom("Consulting Services"),
            pricingMethods: [.fixedRate(0.0)]
        ),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping(.empty),
            serviceType: .maintenance,
            pricingMethods: [.fixedRate(0.0)]
        ),
    ]
}

