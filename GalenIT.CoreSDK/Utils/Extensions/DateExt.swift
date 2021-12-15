import Foundation

public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
//import Foundation
//
//public enum DateFormat: String {
//    case defaultDate = "dd/MM/yy"
////    case midDate = "dd MMM yyyy"
////    case defaultTime = "HH:mm:ss"
//    case defaultTimeMillis = "HH:mm:ss.SSS"
//    case dateDashedWithMillis = "yyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//    case rfc1123 = "EEE',' dd MMM yyyy HH':'mm':'ss z"
////    case avatarDate = "yyy-MM-dd'T'HH:mm:ss'Z'"
////    case dateDashed = "yyyy-MM-dd'T'HH:mm:ss z"
//    case dateAsDDMMMM = "dd MMMM"
//    case dateAsDDMMMMYYYY = "dd MMMM yyyy"
//    case dateAsMMMDDYYYY = "MMM dd, yyyy"
//    case dateAsMMMDD = "MMM dd"
//    case dateAsDayOfWeek = "EEEE"
//    case dateAsDayOfWeekShort = "EEE"
//    case dateAsHHmm = "HH:mm"
//    case dateAsDDMM = "dd.MM"
//    case dateAsDDMMYYY = "dd.MM.yyy"
//    case dateNoYear = "MMMdd"
//    case dateAsEEEMMMDYYYY = "EEE',' MMM d',' yyyy"
//}

public extension Date {
//    enum Format: String {
//        case timeWithMillis = "HH:mm:ss.SSS"
//        case dateDashedWithMillis = "yyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        case rfc1123 = "EEE',' dd MMM yyyy HH':'mm':'ss z"
//    }
}

public extension Date {
    func toString(as format: String, timezone: TimeZone? = .init(secondsFromGMT: 0), locale: Locale = .current) -> String {
        let formatter = DateFormatter()

        formatter.timeZone = timezone
        formatter.locale = locale

        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    func formatted(
            dateStyle: DateFormatter.Style = .none,
            timeStyle: DateFormatter.Style = .none,
            locale: Locale = .current,
            calendar: Calendar = .current
    ) -> String {
        let formatter = DateFormatter()

        formatter.calendar = calendar
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle

        return formatter.string(from: self)
    }
}

public extension String {
    func asUtcDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        formatter.locale = NSLocale(localeIdentifier: "en_us_POSIX") as Locale
        guard let result = formatter.date(from: self) else {
            return nil
        }

        return result
    }
}

public extension Date {
    var toMillis: Int64 {
        Int64(timeIntervalSince1970 * 1000)
    }

    var toSeconds: Int64 {
        Int64(timeIntervalSince1970)
    }

    static func from(millis: Int64?) -> Date? {
        millis.map { number in Date(timeIntervalSince1970: Double(number) / 1000)}
    }

    static func from(millis: Int64) -> Date {
        Date(timeIntervalSince1970: Double(millis) / 1000)
    }

    static func from(seconds: Int64?) -> Date? {
        seconds.map() { number in Date(timeIntervalSince1970: Double(number))}
    }

    static var currentTimeInMillis: Int64 {
        Date().toMillis
    }

    init(fromMillis timeIntervalSince1970inMillis: Int64) {
        let timeIntervalSince1970inMillis = Double(timeIntervalSince1970inMillis)/1000
        self.init(timeIntervalSince1970: timeIntervalSince1970inMillis)
    }

    var timeWithMillis: String {
        "\(self.toString(as: "HH:mm:ss.SSS", timezone: .current))"
    }
}


public extension Int64 {
    var date: Date {
        Date.from(millis: self)
    }
}

public extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        calendar.component(component, from: self)
    }
}

public extension Date {
    func addYears(
            years: Int = 0,
            months: Int = 0,
            days: Int = 0,
            hours: Int = 0,
            minutes: Int = 0,
            seconds: Int = 0
    ) -> Date {
        var dateComponent = DateComponents()
        dateComponent.year = years
        dateComponent.month = months
        dateComponent.day = days
        dateComponent.hour = hours
        dateComponent.minute = minutes
        dateComponent.second = seconds

        return
                Calendar.current.date(byAdding: dateComponent, to: self)
                ?? self
    }
}

public extension Date {
    func years(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }

    func months(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }

    func days(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }

    func hours(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }

    func minutes(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }

    func seconds(sinceDate: Date) -> Int? {
        Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
}
