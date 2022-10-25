public extension StringProtocol where Self == String {
    static var emptyString: String {
        return ""
    }
}

public extension StringProtocol where Self == String {
    static var whitespace: String {
        return " "
    }
}

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

    func clean(pattern: String) -> String {
        self.replacingOccurrences(
                of: pattern,
                with: "",
                options: .regularExpression,
                range: nil
        )
    }

    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

public extension String {

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

public extension String {
    var doubleVal: Double? {
        let clear = self.replacingOccurrences(of: ",", with: ".")
        return Double(clear)
    }
}
