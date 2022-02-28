import Foundation

public class PhoneUtils {
   private static let phoneLib = PhoneNumberKit()

    public static func cleanPhoneNumber(_ phoneNum: String) -> String {
        phoneNum.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
    }

    public static func parse(phone: String) -> PhoneNum {
        let result = tryParse(rawNumber: phone, format: .e164)

        return .init(
                number: result.valid ? result.formatted : cleanPhoneNumber(result.formatted)
        )
    }

    public static func tryParse(rawNumber: String, format: PhoneFormat, withRegion: String? = nil) -> PhoneParseResult {
        do {
            let number = rawNumber.hasPrefix("+") ? rawNumber : "+\(rawNumber)"
            let phoneNumber: PhoneNumber
            if let region = withRegion {
                phoneNumber = try phoneLib.parse(number, withRegion: region)
            } else {
                phoneNumber = try phoneLib.parse(number)
            }

            let formatted: String
            switch format {
            case .e164:
                formatted = phoneLib.format(phoneNumber, toType: .e164)
            case .international:
                formatted = phoneLib.format(phoneNumber, toType: .international)
            case .national:
                formatted = phoneLib.format(phoneNumber, toType: .national)
            }
            return PhoneParseResult(
                    formatted: formatted,
                    valid: phoneLib.isValidPhoneNumber(formatted, ignoreType: true),
                    parsed: true,
                    phoneCode: Int(phoneNumber.countryCode),
                    iso: phoneLib.getRegionCode(of: phoneNumber),
                    ext: phoneNumber.numberExtension
            )
        } catch {
            return PhoneParseResult(formatted: rawNumber)
        }
    }

    public static func getRandomPhoneWithExt() -> PhoneNum {
        .init(number: getRandomPhone())
    }

    public static func getRandomPhone() -> String {
        for _ in 1...1000 {
            let candidate = "+7929\(Int.random(in: 0...9999999))"
            if tryParse(rawNumber: candidate, format: .e164).valid {
                return candidate
            }
        }

        return "+7929\(Int.random(in: 0...9999999))"
    }

    public static func getExample(for iso: String) -> String? {
        let number = phoneLib.getExampleNumber(forCountry: iso, ofType: .mobile)

        guard let num = number else {
            return nil
        }

        return phoneLib.format(num, toType: .e164)
    }
}
