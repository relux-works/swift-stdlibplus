import Foundation

public struct PhoneNum {
    public let number: String

    public init() {
        self.number = ""
    }

    public init?(number: String?) {
        guard
                let number = number else {
            return nil
        }
        self.number = PhoneUtils.cleanPhoneNumber(number)
    }

    public init(number: String) {
        self.number = PhoneUtils.cleanPhoneNumber(number)
    }

    public var toString: String {
        "+\(number)"
    }


    public var international: PhoneParseResult {
        PhoneUtils.tryParse(rawNumber: number, format: .international)
    }

    public var national: PhoneParseResult {
        PhoneUtils.tryParse(rawNumber: number, format: .national)
    }

    public var e164: PhoneParseResult {
        PhoneUtils.tryParse(rawNumber: number, format: .e164)
    }

    public var isEmpty: Bool {
        number.isEmpty
    }

    public var isNotEmpty: Bool {
        self.isEmpty.not
    }
}
