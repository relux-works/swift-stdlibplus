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

public extension PersonNameComponentsFormatter {
    static var mediumNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .medium
        return formatter
    }()
    
    static var shortNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .short
        return formatter
    }()
    
    static var longNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .long
        return formatter
    }()
    
    static var abbreviatedNameLength: PersonNameComponentsFormatter = {
        let formatter: PersonNameComponentsFormatter = .init()
        formatter.style = .abbreviated
        return formatter
    }()
}
