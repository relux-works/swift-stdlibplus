import Tagged
import Foundation

public struct Country: Equatable, Hashable, Codable  {
    public let iso: Iso
    public let phoneCode: PhoneCode
    public let countryCode: CountryCode
    public let name: Name

    public init(
            iso: String,
            countryCode: Int,
            phoneCode: Int,
            name: String
    ) {
        self.iso = .init(rawValue: iso)
        self.phoneCode = .init(rawValue: phoneCode)
        self.countryCode = .init(rawValue: countryCode)
        self.name = .init(rawValue: name)
    }

    public static func ==(lhs: Country, rhs: Country) -> Bool {
        lhs.iso == rhs.iso
    }
}

public extension Country {
    enum _Iso {}
    enum _Name {}
    enum _PhoneCode {}
    enum _CountryCode {}

    typealias Name = Tagged<_Name, String>
    typealias Iso = Tagged<_Iso, String>
    typealias PhoneCode = Tagged<_PhoneCode, Int>
    typealias CountryCode = Tagged<_CountryCode, Int>
}

public extension Country {
    var localizedName: String {
        let locale = NSLocale.current as NSLocale
        let name = locale.displayName(forKey: .countryCode, value: iso.rawValue)

        return name ?? ""
    }

    var emoji: String {
        let iso = iso.rawValue.uppercased()
        let emoji = iso
                .unicodeScalars
                .compactMap {
                    UnicodeScalar(127397 + $0.value)
                }
                .map { String($0) }
                .joined()

        return emoji
    }
}
