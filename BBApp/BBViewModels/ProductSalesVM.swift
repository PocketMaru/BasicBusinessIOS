//
//  ProductSalesVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/29/25.
//

import Foundation
@Observable
final class ProductSalesVM {
    var inventory: [InventoryItemModel] = []
    init(inventory: [InventoryItemModel]) {
        self.inventory = inventory
    }
    
    func convertToBaseUnit(quantity: Double, unit: ProductUnitTypes) -> Double {
        switch unit {
        case .gram: return quantity
        case .ounce: return quantity * 28.3495
        case .pound: return quantity * 453.592
        case .bag: return quantity
        case .gallon: return quantity
        case .liter: return quantity * 3.78541
        case .unit: return quantity
        case .piece: return quantity
        }
    }
    
    func addProduct(_ product: InventoryItemModel) {
        inventory.append(product)
    }
    
    func removeProduct(id: UUID, quantityToRemove: Int, unit: ProductUnitTypes) {
        guard let index = inventory.firstIndex(where: {$0.id == id}) else { return }
        
        let baseQuantity = convertToBaseUnit(quantity: Double(quantityToRemove), unit: unit)
        
        guard baseQuantity <= inventory[index].productQuantity else {
            print("Cannot remove more than available stock")
            return
        }
        
        inventory[index].productQuantity -= baseQuantity
        
        if inventory[index].productQuantity < 0 {
            inventory[index].productQuantity = 0
        }
        
        if inventory[index].productQuantity == 0 {
            print("Item \(inventory[index].name) is out of stock.")
        }
    }
    
    func deleteFromInventory(id: UUID) {
        guard let index = inventory.firstIndex(where: {$0.id == id}) else { return }
        inventory.remove(at: index)
    }
    
    func adjustProductQuantity(for id: UUID, by amount: Double) {
        guard let index = inventory.firstIndex(where: { $0.id == id }) else { return }
        inventory[index].productQuantity = max(0, inventory[index].productQuantity + amount)
    }
    
}
