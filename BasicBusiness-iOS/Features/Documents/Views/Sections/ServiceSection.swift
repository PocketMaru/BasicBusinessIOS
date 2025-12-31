import SwiftUI

struct ServiceSection: View {
    @Binding var serviceType: ServiceType
    @Binding var customServiceName: String
    @FocusState var isFocused: Bool
    let isVisible: Bool
    
    var body: some View {
        if isVisible {
            VStack(alignment: .leading, spacing: 6) {
                Text("Service Type")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 15)
                
                Menu {
                    ForEach(ServiceType.allCases.filter { $0 != .none }) { service in
                        Button(service.displayName) {
                            serviceType = service
                        }
                    }
                } label: {
                    HStack {
                        Text(
                            serviceType == .none
                            ? "Select service"
                            : serviceType.displayName
                        )
                        .foregroundStyle(
                            serviceType == .none
                            ? AppColors.secondaryText
                            : AppColors.secondaryText
                        )
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .padding(.horizontal, 15)
                }
                
                if serviceType == .custom {
                    VStack(alignment: .leading, spacing: 5) {

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
        }
    }
}
