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
    // Function converting the stored product to a base unit.
    func convertToBaseUnit(quantity: Double,to unit: ProductUnitTypes) -> Double {
        switch unit {
        case .gram: return quantity
        case .ounce: return quantity * 28.3495
        case .pound: return quantity * 453.592
        case .liter: return quantity
        case .gallon: return quantity * 3.78541
        default: return quantity
        }
    }
    // Function returning the product base unit to larger unit.
    func convertFromBaseUnit(quantity: Double, unit: ProductUnitTypes) -> Double {
        switch unit {
        case .gram: return quantity
        case .ounce: return quantity / 28.3495
        case .pound: return quantity / 453.592
        case .bag: return quantity
        case .gallon: return quantity / 3.78541
        case .liter: return quantity
        case .unit: return quantity
        case .piece: return quantity
        }
    }
    // Function adding products to inventory
    func addProduct(_ product: InventoryItemModel) {
        inventory.append(product)
    }
    // Function to remove the quantity selected by the user.
    func removeProduct(id: UUID, quantityToRemove: Int, unit: ProductUnitTypes) {
        guard let index = inventory.firstIndex(where: {$0.id == id}) else { return }
        
        let product = inventory[index]
        
        let baseQuantityToRemove = convertToBaseUnit(quantity: Double(quantityToRemove), to: unit)
        
        if baseQuantityToRemove > product.productQuantity {
            print("Cannot remove more than available stock")
            return
        }
        
        inventory[index].productQuantity -= baseQuantityToRemove
        
        if inventory[index].productQuantity <= 0 {
            inventory[index].productQuantity = 0
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
    
    func displayQuantity(for product: InventoryItemModel, as unit: ProductUnitTypes) -> String {
        let converted = convertFromBaseUnit(quantity: product.productQuantity, unit: unit)
        return String(format: "%.2f %@", converted, unit.displayName)
    }
}
