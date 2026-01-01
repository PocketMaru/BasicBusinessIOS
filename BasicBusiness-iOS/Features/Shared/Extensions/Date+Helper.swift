import Foundation

enum DocumentDateFilter {
    case today
    case thisWeek
    case thisMonth
    case custom(start: Date, end: Date)

    func matches(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = Date()

        switch self {
        case .today:
            return calendar.isDate(date, inSameDayAs: today)

        case .thisWeek:
            return calendar.isDate(date, equalTo: today, toGranularity: .weekOfYear)

        case .thisMonth:
            return calendar.isDate(date, equalTo: today, toGranularity: .month)

        case .custom(let start, let end):
            return (date >= start && date <= end)
        }
    }
}

extension Date {
    
    var formattedMonthDayYear: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func isInSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    func isInSameMonth(as other: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: other, toGranularity: .month)
    }

    func isInSameWeek(as other: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: other, toGranularity: .weekOfYear)
    }

    static var today: Date { Date() }
    
    func currentMonth(_ date: Date) -> String {
        date.formatted(.dateTime.month(.wide))
    }
    
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: .today)!
    }

    static var lastWeek: Date {
        Calendar.current.date(byAdding: .day, value: -7, to: .today)!
    }

    static func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: .today)!
    }

    static func monthsAgo(_ months: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: -months, to: .today)!
    }
    
    static func netDate(_ days: Int, from base: Date = .today) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: base) ?? base
    }
}
