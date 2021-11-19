import Tagged
import Foundation

struct Country: Equatable, Hashable, Codable  {
    let iso: Iso
    let phoneCode: PhoneCode
    let countryCode: CountryCode
    let name: Name

    init(
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

    static func ==(lhs: Country, rhs: Country) -> Bool {
        lhs.iso == rhs.iso
    }
}

extension Country {
    enum _Iso {}
    enum _Name {}
    enum _PhoneCode {}
    enum _CountryCode {}

    typealias Name = Tagged<_Name, String>
    typealias Iso = Tagged<_Iso, String>
    typealias PhoneCode = Tagged<_PhoneCode, Int>
    typealias CountryCode = Tagged<_CountryCode, Int>
}

extension Country {
    public var localizedName: String {
        let locale = NSLocale.current as NSLocale
        let name = locale.displayName(forKey: .countryCode, value: iso.rawValue)

        return name ?? ""
    }

    public var emoji: String {
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