import SwiftUI

struct ServiceSection: View {
    @Binding var serviceType: ServiceType
    @Binding var customServiceName: String
    @FocusState var isFocused: Bool
    @State private var isExpanded: Bool = false
    let isVisible: Bool
    
    var body: some View {
        if isVisible {
            VStack(alignment: .leading, spacing: 6) {
                DisclosureGroup(isExpanded: $isExpanded ) {
                    serviceChoice()
                } label: {
                    serviceLabel()
                }
                .padding(.trailing, 20)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func serviceChoice() -> some View {
        Picker("Service Type", selection: $serviceType) {
            ForEach(ServiceType.allCases.filter { $0 != .none }) { service in
                Text(service.displayName)
                    .tag(service)
            }
        }
        .pickerStyle(.wheel)
        .padding(.horizontal, 15)
        
        VStack(alignment: .leading) {
            Text("Selected Service")
                .foregroundStyle(AppColors.accent)
                .padding(.horizontal, 15)
            Divider()
            Text("\(serviceType.displayName.capitalized)")
                .font(.headline)
                .foregroundStyle(AppColors.secondaryText)
                .padding(.horizontal, 15)
        }
        
        if serviceType == .custom {
            VStack(alignment: .leading, spacing: 5) {
                Divider()
                Text("Custom Service Name")
                    .foregroundStyle(AppColors.accent)

                TextField(
                    "e.g. Gutter Cleaning",
                    text: $customServiceName
                )
                .focused($isFocused)
                .textFieldStyle(.plain)
                .padding(.vertical, 6)
                .foregroundStyle(AppColors.secondaryText)
            }
            .padding(.horizontal, 15)
        }
    }
    
    @ViewBuilder
    private func serviceLabel() -> some View {
        if serviceType == .none {
            Text("Service Type")
                .foregroundStyle(AppColors.accent)
                .padding(.horizontal, 15)
        } else if serviceType == .custom {
            HStack {
                Text("Service Type:")
                    .foregroundStyle(AppColors.accent)
                Text("\(customServiceName.capitalized)")
                    .foregroundStyle(AppColors.secondaryText)
            }
            .padding(.horizontal, 15)
        } else {
            HStack {
                Text("Service Type:")
                    .foregroundStyle(AppColors.accent)
                Text("\(serviceType.displayName.capitalized)")
                    .foregroundStyle(AppColors.secondaryText)
            }
            .padding(.horizontal, 15)
        }
    }
}
