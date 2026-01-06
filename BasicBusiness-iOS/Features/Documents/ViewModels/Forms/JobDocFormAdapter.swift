import SwiftUI

/// Provides all form bindings to the router
struct JobDocFormAdapter {
    var serviceType: Binding<ServiceType>
    var customService: Binding<String>
    var pricingMethods: Binding<[PricingMethodModel]>
    var customFields: Binding<[CustomFieldModel]>
    var notes: Binding<String>
    var creationDate: Binding<Date>
    var dueDate: Binding<Date>
    var installationDate: Binding<Date>
    var serviceDate: Binding<Date>
    var customDate: Binding<Set<DateComponents>>
    
    var netTerms: (Int) -> Void
    var formTitle: String
    var total: Double
}
