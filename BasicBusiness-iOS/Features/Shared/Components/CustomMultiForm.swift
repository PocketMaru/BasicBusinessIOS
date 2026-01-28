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
    case industryPicker(Binding<IndustryChoice>)
    case servicePicker(Binding<ServiceType>)
    case materialTypePicker(Binding<ProductUnitTypes>)
    case customField(Binding<[CustomFieldModel]>)
    case textField(Binding<String>, placeholder: String? = nil)
    case currencyField(Binding<String>)
    case none
}

struct DetailField: Identifiable {
    var id: String { title }
    let title: String
    let value: String?
    let edit: EditControl
    let errorMessage: String?
}

struct MultiForm: View {
    let fields: [DetailField]
    let isEditing: Bool
    let attemptedSave: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(fields) { field in
                Text(field.title)
                    .fontWeight(.medium)
                    .foregroundStyle(AppColors.accent)
                if isEditing {
                    editView(for: field.edit)
                    if attemptedSave {
                        if let error = field.errorMessage {
                            Text(error)
                                .foregroundStyle(AppColors.error)
                                .frame(minHeight: 16, alignment: .leading)
                        }
                    }
                } else if let value = field.value {
                    Text(value)
                        .foregroundStyle(AppColors.secondaryText)
                        .fontWeight(.semibold)
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
                ForEach(IndustryChoice.all) { type in
                    Text(type.displayName).tag(type)
                }
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        case .servicePicker(let binding):
            Picker("Service", selection: binding) {
                ForEach(ServiceType.allCases, id: \.self) { type in
                    Text(type.displayName).tag(type)
                        .foregroundStyle(AppColors.secondaryText)
                }
            }
            .fontWeight(.semibold)
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        case .materialTypePicker(let binding):
            Picker("Material", selection: binding) {
                ForEach(ProductUnitTypes.allCases, id: \.self) { type in
                    Text(type.displayName).tag(type)
                }
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        case .customField(let fieldsBinding):
            ForEach(fieldsBinding) { $binding in
                TextField("", text: $binding.label)
                TextField("", value: $binding.value, format: .currency(code: "USD"))
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        case .textField(let binding, let placeholder):
            TextField(placeholder ?? "", text: binding)
                .fontWeight(.semibold)
                .foregroundStyle(AppColors.secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        case .currencyField(let binding):
            TextField("", text: binding)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
