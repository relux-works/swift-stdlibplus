import Foundation

public extension DateComponents {
    var asDate: Date? {
        Calendar.current.date(from: self)
    }
}