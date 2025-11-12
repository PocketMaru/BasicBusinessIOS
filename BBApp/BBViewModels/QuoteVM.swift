//
//  QuoteVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

@Observable
final class QuoteVM {
    var quotes: [QuoteModel] = []
    
    var draftQuote: QuoteModel 
    
    var savedMaterials: [MaterialModel]
    
    var quoteMaterials: [MaterialExpenseQM] = []
    
    var customerSelection: [CustomerModel] = []
    
    var selectedCustomer: CustomerModel? = nil
    
    init(existingQuotes: [QuoteModel] = [], savedMaterials: [MaterialModel], draftQuote: QuoteModel) {
        self.quotes = existingQuotes
        self.savedMaterials = savedMaterials
        self.draftQuote = draftQuote
    }
    
    func loadIndustryFields(for industry: IndustryType) {
        switch industry {
            case .landscaping:
            draftQuote.pricingMethods = [.squareFootage(amount: 0, rate: 0)]
            case .consulting:
            draftQuote.pricingMethods = [.fixedRate(0)]
            case .productSales:
            draftQuote.pricingMethods = [.fixedRate(0)]
            case .pressureWashing:
            draftQuote.pricingMethods = [.liquidSolution(amount: 0, rate: 0)]
            case .handyman:
            draftQuote.pricingMethods = [.fixedRate(0)]
            case .HVAC:
            draftQuote.pricingMethods = [.fixedRate(0)]
            case .none:
            draftQuote.pricingMethods = [.fixedRate(0)]
        }
    }
    
    func startNewQuote(for customer: CustomerModel, industry: IndustryType) -> QuoteModel {
        quoteMaterials.removeAll()
        loadIndustryFields(for: industry)
        let newQuote = QuoteModel(
            customer: customer,
            industryType: industry,
            serviceType: .maintenance,
            pricingMethods: draftQuote.pricingMethods
        )
        return newQuote
    }
    
    func quoteIsValid() -> Bool {
        let hasCustomer = true
        let hasTotal = draftQuote.totalCost > 0
        return hasCustomer && hasTotal
                            
    }
    
    func addMaterialToQuote(from savedMaterial: MaterialModel, markAsExpense: Bool = false) {
        let quoteMaterial = MaterialExpenseQM(from: savedMaterial, addedAsExpense: markAsExpense)
        quoteMaterials.append(quoteMaterial)
    }
    
    func saveDraftToQuote() {
        guard selectedCustomer != nil else { return }
        quotes.append(draftQuote)
    }
}
