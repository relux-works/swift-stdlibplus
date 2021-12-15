import Foundation

public struct PhoneParseResult {
    public let formatted: String
    public let valid: Bool
    public let parsed: Bool
    public let phoneCode: Int?
    public let iso: String?
    public let ext: String?

    public init(
            formatted: String,
            valid: Bool = false,
            parsed: Bool = false,
            phoneCode: Int? = nil,
            iso: String? = nil,
            ext: String? = nil
    ) {
        self.formatted = formatted
        self.valid = valid
        self.parsed = parsed
        self.phoneCode = phoneCode
        self.iso = iso
        self.ext = ext
    }
}
