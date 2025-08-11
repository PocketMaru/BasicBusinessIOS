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

protocol Quoteable {
    var id: UUID {get}
    var customerID: UUID {get}
    var industryType: IndustryType {get}
    var pricingMethod: PricingMethod {get}
    var quoteDate: Date {get}
    var notes: String? {get}
    var totalCost: Double? {get}
}

struct QuoteModel: Identifiable, Quoteable {
    var id: UUID = UUID()
    var customer: CustomerModel
    var customerID: UUID {
        customer.id
    }
    var industryType: IndustryType
    var serviceType: ServiceType
    var pricingMethod: PricingMethod
    var quoteDate: Date = Date()
    var installationDate: Date?
    var serviceDate: Date?
    var notes: String?
    var subscriptionTotal: Double?
    var materialCost: Double?
    var laborCost: Double?
    var additionalFees: Double?
    var totalCost: Double?
    var customFields: Data?
    var materialExpenses: [MaterialExpenseQM]? = nil
    var materialTotalCost: Double? {
        materialExpenses?.reduce(0) { $0 + $1.unitCost }
    }
    // Pending expenses, these are expenses tied to quotes, this allows the user to see what expenses will be when a job converts to invoice, allowing forecasting of future expenses from jobs.
    var pendingMaterialExpense: [MaterialExpensePreview] = []
    
    init(
        id: UUID = UUID(),
        customer: CustomerModel,
        industryType: IndustryType,
        serviceType: ServiceType,
        pricingMethod: PricingMethod,
        quoteDate: Date = Date(),
        installationDate: Date? = nil,
        serviceDate: Date? = nil,
        notes: String? = nil,
        subscriptionTotal: Double? = nil,
        materialCost: Double? = nil,
        laborCost: Double? = nil,
        additionalFees: Double? = nil,
        totalCost: Double? = nil,
        customFields: Data? = nil,
        materialExpenses: [MaterialExpenseQM]? = nil,
        pendingExpenses: [MaterialExpensePreview] = []
    ) {
        self.id = id
        self.customer = customer
        self.industryType = industryType
        self.serviceType = serviceType
        self.pricingMethod = pricingMethod
        self.quoteDate = quoteDate
        self.installationDate = installationDate
        self.serviceDate = serviceDate
        self.notes = notes
        self.subscriptionTotal = subscriptionTotal
        self.materialCost = materialCost
        self.laborCost = laborCost
        self.additionalFees = additionalFees
        self.totalCost = totalCost
        self.customFields = customFields
        self.materialExpenses = materialExpenses
        self.pendingMaterialExpense = pendingExpenses
    }
}

enum ServiceType {
    case installation
    case maintenance
    case repair
    case recurring
    case custom(String)
    
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
        }
    }
}

enum PricingMethod {
    case fixedRate
    case hourlyRate
    case squareFootage
    case subscription
    
    var name: String {
        switch self {
        case .fixedRate:
            return "Fixed Rate"
        case .hourlyRate:
            return "Hourly Rate"
        case .squareFootage:
            return "Square Footage"
        case .subscription:
            return "Subscription"
        }
    }
}

extension QuoteModel {
    static let sample = QuoteModel(
        customer: .sample,
        industryType: .landscaping,
        serviceType: .installation,
        pricingMethod: .fixedRate,
        notes: "This is a sample quote."
    )
    
    static let sampleList: [QuoteModel] = [
        .sample,
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .maintenance,
            pricingMethod: .subscription,
            totalCost: 300),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .pressureWashing,
            serviceType: .maintenance,
            pricingMethod: .fixedRate,
            totalCost: 3000),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .HVAC,
            serviceType: .maintenance,
            pricingMethod: .fixedRate,
            totalCost: 1000),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .consulting,
            serviceType: .custom("Consulting Services"),
            pricingMethod: .fixedRate,
            totalCost: 250),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .handyman,
            serviceType: .maintenance,
            pricingMethod: .fixedRate,
            totalCost: 3000),
    ]
}

