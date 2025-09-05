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
    
    func startNewQuote(for customer: CustomerModel) {
        self.selectedCustomer = customer
        self.draftQuote = QuoteModel(
            customer: customer,
            industryType: .landscaping,
            serviceType: .maintenance,
            pricingMethod: .fixedRate,
            totalCost: 0
        )
        quoteMaterials.removeAll()
    }
    
    func quoteIsValid() -> Bool {
        let hasCustomer = true
        let hasRequiredFields =
        draftQuote.industryType != .none &&
        draftQuote.serviceType != ServiceType.none &&
        draftQuote.pricingMethod != .none
        let hasTotal = draftQuote.totalCost > 0
        return hasCustomer && hasRequiredFields && hasTotal
                            
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
