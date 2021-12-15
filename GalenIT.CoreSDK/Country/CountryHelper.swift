import Foundation

public class CountryHelper {
    public static func getCountry(_ name: String) -> Country? {
        countries.first { $0.localizedName == name }
    }

    public static func getCountry(_ countryCode: Country.CountryCode) -> Country? {
        countries.first { $0.countryCode == countryCode }
    }

//    static func getCountry(by phone: PhoneNumber?) -> Country? {
//        guard let iso = phone?.e164.iso else {
//            return nil
//        }
//        return self.getCountry(Country.Iso(rawValue: iso))
//    }

    public static func getCountry(_ iso: Country.Iso?) -> Country? {
        guard let iso = iso else {
            return nil
        }

        return countries.first { $0.iso == iso }
    }

    public static var countries: [Country] {
        get {
            CountriesResource.countries
        }
    }
}
