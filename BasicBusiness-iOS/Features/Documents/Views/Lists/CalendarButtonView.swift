import SwiftUI

struct CalendarQuickActions: View {
    let dismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading ,spacing: 12) {
            calendarButton(icon: "calendar.circle.fill", label: "Today") {
                // apply filter
                dismiss()
            }

            calendarButton(icon: "calendar.badge.clock", label: "This Week") {
                // apply filter
                dismiss()
            }

            calendarButton(icon: "calendar", label: "This Month") {
                // apply filter
                dismiss()
            }
        }
        .padding(14)
    }

    private func calendarButton(
        icon: String,
        label: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title3.bold())
                    .foregroundStyle(AppColors.accent)

                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                Capsule()
                    .fill(AppColors.accent.opacity(0.04))
                    .statBubbleStyle()
            )
        }
    }
}
