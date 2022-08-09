import Foundation

public protocol AnyDated {
    var date: Date { get }
}

public extension Sequence where Element: AnyDated {
    func groupBy(_ cadence: Cadence) -> Dictionary<DateComponents, [Element]> {
        Dictionary(grouping: self) { (item: AnyDated) -> DateComponents in
            Calendar.current.dateComponents(cadence.calendarComponents, from: (item.date))
        }
    }
}

public enum Cadence {
    case years
    case months
    case weeks
    case days
    case hours
    case minutes

    public var calendarComponents: Set<Calendar.Component> {
        switch self {
        case .years: return [.year]
        case .months: return [.year, .month]
        case .weeks: return [.year, .month, .weekOfMonth]
        case .days: return [.year, .month, .day]
        case .hours: return [.year, .month, .day, .hour]
        case .minutes: return [.year, .month, .day, .hour, .minute]
        }
    }
}
