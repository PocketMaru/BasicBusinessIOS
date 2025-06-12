//
//  InvoiceVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/11/25.
//

import Foundation

@Observable
class InvoiceVM {
    var invoice: [InvoiceModel] = []
    var customer: [CustomerModel] = []
    
    func removeInvoice(_ index: Int) {
        invoice.remove(at: index)
    }
    
    func searchForInvoice(by customerID: UUID) -> [InvoiceModel] {
        invoice.filter { $0.customerID == customerID }
    }
}
