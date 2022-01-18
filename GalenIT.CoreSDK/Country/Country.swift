import Foundation

public struct Country: Equatable, Hashable, Codable  {
    public let iso: String
    public let phoneCode: Int
    public let countryCode: Int
    public let name: String

    public init(
            iso: String,
            countryCode: Int,
            phoneCode: Int,
            name: String
    ) {
        self.iso = iso
        self.phoneCode = phoneCode
        self.countryCode = countryCode
        self.name = name
    }

    public static func ==(lhs: Country, rhs: Country) -> Bool {
        lhs.iso == rhs.iso
    }
}

public extension Country {
    var localizedName: String {
        let locale = NSLocale.current as NSLocale
        let name = locale.displayName(forKey: .countryCode, value: iso)

        return name ?? ""
    }

    var emoji: String {
        let iso = iso.uppercased()
        let emoji = iso
                .unicodeScalars
                .compactMap { UnicodeScalar(127397 + $0.value) }
                .map { String($0) }
                .joined()

        return emoji
    }
}
