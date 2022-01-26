import Foundation

// A set of cached predefenied formatters for convinient and efficient use from SwiftUI
public extension DateFormatter {
    static var mediumDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static var shortDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    static var longDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    static var fullDateStyle: DateFormatter = {
        let formatter: DateFormatter = .init()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
}
