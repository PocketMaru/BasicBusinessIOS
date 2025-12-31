import SwiftUI
import Foundation

struct CustomMultiForm: View {
    let titleOne: String
    let valueOne: String
    let titleTwo: String?
    let valueTwo: String?
    let titleThree: String?
    let valueThree: String?
    let titleFour: String?
    let valueFour: String?
    let titleFive: String?
    let valueFive: String?
    let titleSix: String?
    let valueSix: String?
    let titleSeven: String?
    let valueSeven: String?
    let titleEight: String?
    let valueEight: String?
    let titleNine: String?
    let valueNine: String?
    let titleTen: String?
    let valueTen: String?
    let titleEleven: String?
    let valueEleven: String?
    
    init(
        titleOne: String,
        valueOne: String,
        titleTwo: String?,
        valueTwo: String?,
        titleThree: String?,
        valueThree: String?,
        titleFour: String?,
        valueFour: String?,
        titleFive: String?,
        valueFive: String?,
        titleSix: String?,
        valueSix: String?,
        titleSeven: String?,
        valueSeven: String?,
        titleEight: String?,
        valueEight: String?,
        titleNine: String?,
        valueNine: String?,
        titleTen: String?,
        valueTen: String?,
        titleEleven: String?,
        valueEleven: String?,
    ) {
        self.titleOne = titleOne
        self.valueOne = valueOne
        self.titleTwo = titleTwo
        self.valueTwo = valueTwo
        self.titleThree = titleThree
        self.valueThree = valueThree
        self.titleFour = titleFour
        self.valueFour = valueFour
        self.titleFive = titleFive
        self.valueFive = valueFive
        self.titleSix = titleSix
        self.valueSix = valueSix
        self.titleSeven = titleSeven
        self.valueSeven = valueSeven
        self.titleEight = titleEight
        self.valueEight = valueEight
        self.titleNine = titleEight
        self.valueNine = valueEight
        self.titleTen = titleEight
        self.valueTen = valueEight
        self.titleEleven = titleEight
        self.valueEleven = valueEight
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(titleOne)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(AppColors.accent)
           
            Text(valueOne)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.secondaryText)
            Divider()
            
            if let titleTwo = titleTwo {
                Text(titleTwo)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueTwo = valueTwo {
                Text(valueTwo)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                Divider()
            }
            
            
            if let titleThree = titleThree {
                Text(titleThree)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueThree = valueThree {
                Text(valueThree)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                Divider()
            }
            
            
            if let titleFour = titleFour {
                Text(titleFour)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueFour = valueFour {
                Text(valueFour)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
            }
            
            if let titleFive = titleFive {
                Divider()
                Text(titleFive)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueFive = valueFive {
                Text(valueFive)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                
            }
            
            
            if let titleSix = titleSix {
                Divider()
                Text(titleSix)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueSix = valueSix {
                Text(valueSix)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                
            }
            
            
            if let titleSeven = titleSeven {
                Divider()
                Text(titleSeven)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueSeven = valueSeven {
                Text(valueSeven)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
            }
            if let titleEight = titleEight {
                Divider()
                Text(titleEight)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueEight = valueEight {
                Text(valueEight)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
            }
            
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .statBubbleStyle()
    }
}

// MARK: - Future detail form view refactor
enum EditControl {
    case industryPicker(Binding<IndustryType>)
    case servicePicker(Binding<ServiceType>)
    case customField(Binding<[CustomField]>)
    case textField(Binding<String>)
    case currencyField(Binding<Double>)
    case none
}

struct DetailField: Identifiable {
    let id = UUID()
    let title: String
    let value: String?
    let edit: EditControl
}

struct MultiForm: View {
    let fields: [DetailField]
    let isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(fields) { field in
                Text(field.title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
                if isEditing {
                    editView(for: field.edit)
                    if let value = field.value { Text(value) }
                }
                if field.id != fields.last?.id {
                    Divider()
                }
            }
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .statBubbleStyle()
    }
    
    @ViewBuilder
    private func editView(for control: EditControl) -> some View {
        
        switch control {
        case .industryPicker(let binding):
            Picker("Industry", selection: binding) {
                ForEach(IndustryChoice.all) {
                    Text($0.displayName).tag($0.type)
                }
            }
        case .servicePicker(let binding):
            Picker("Service", selection: binding) {
                ForEach(ServiceType.allCases) {
                    Text($0.displayName)
                }
            }
            
        case .customField(let binding):
            ForEach(binding) { binding in
                TextField("", text: binding.label)
                TextField("", value: binding.value, format: .currency(code: "USD"))
            }
            
        case .textField(let binding):
            TextField("", text: binding)
        case .currencyField(let binding):
            TextField("", value: binding, format: .currency(code: "USD"))
        case .none:
            EmptyView()
        }
    }
}

//  Future implementation of the custom form view
//
//     MultiForm(fields: [
//    .init(title: "Name", value: customer.fullName),
//    .init(title: "Email", value: customer.email ?? "None"),
//    .init(title: "Phone", value: customer.phone),
//    .init(title: "Start Date", value: customer.startDate.formattedMonthDayYear)
//])
