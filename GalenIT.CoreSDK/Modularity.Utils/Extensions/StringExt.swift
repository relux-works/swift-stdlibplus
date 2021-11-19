import Foundation
import CommonCrypto

public extension String {
    var removingWhitespaces: String {
        components(separatedBy: .whitespaces).joined()
    }
    func replacingWhitespaces(with character: Character) -> Self {
        components(separatedBy: .whitespaces).joined(separator: String(character))
    }
}

public extension String {
    func cleanHtml() -> String {
        self.replacingOccurrences(
                of: "<[^>]+>",
                with: "",
                options: .regularExpression,
                range: nil
        )
    }

    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale(localeIdentifier: "en_us_POSIX") as Locale

        return formatter.date(from: self)
    }

    func clean(pattern: String) -> String {
        self.replacingOccurrences(
                of: pattern,
                with: "",
                options: .regularExpression,
                range: nil
        )
    }

    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }


    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

public extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

public extension String {
    var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    var toBase64: String {
        Data(self.utf8).base64EncodedString()
    }
}

extension String {

    var length: Int {
        count
    }

    subscript (i: Int) -> String {
        self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}