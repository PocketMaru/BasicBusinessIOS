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
    
    var draftQuote: QuoteModel?
    
    var savedMaterials: [MaterialModel]
    
    var quoteMaterials: [MaterialExpenseQM] = []
    
    var customerSelection: [CustomerModel] = []
    
    var selectedCustomer: CustomerModel? = nil
    
    init(existingQuotes: [QuoteModel] = [], savedMaterials: [MaterialModel]) {
        self.quotes = existingQuotes
        self.savedMaterials = savedMaterials
    }
    
    func startNewQuote(for customer: CustomerModel) {
        self.selectedCustomer = customer
        self.draftQuote = QuoteModel(
            customer: customer,
            industryType: .landscaping,
            serviceType: .maintenance,
            pricingMethod: .fixedRate
        )
        quoteMaterials.removeAll()
    }
    
    func addMaterialToQuote(from savedMaterial: MaterialModel, markAsExpense: Bool = false) {
        let quoteMaterial = MaterialExpenseQM(from: savedMaterial, addedAsExpense: markAsExpense)
        quoteMaterials.append(quoteMaterial)
    }
    
    func saveDraftToQuote() {
        guard selectedCustomer != nil else { return }
        if let quote = draftQuote {
            quotes.append(quote)
        }
    }
}
