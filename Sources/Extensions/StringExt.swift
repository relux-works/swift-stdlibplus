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

public extension StringProtocol where Self == String {
	static var forwardSlash: String {
		return "/"
	}
}

public extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

public extension String {
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
