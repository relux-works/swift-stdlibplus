import Foundation

public class CountryHelper {
    public static func getCountry(name: String) -> Country? {
        countries.first { $0.localizedName == name }
    }

    public static func getCountry(countryCode: Int) -> Country? {
        countries.first { $0.countryCode == countryCode }
    }

//    static func getCountry(by phone: PhoneNumber?) -> Country? {
//        guard let iso = phone?.e164.iso else {
//            return nil
//        }
//        return self.getCountry(Country.Iso(rawValue: iso))
//    }

    public static func getCountry(iso: String?) -> Country? {
        guard let iso = iso else {
            return nil
        }

        return countries.first { $0.iso == iso.uppercased() }
    }

    public static var countries: [Country] {
        get {
            CountriesResource.countries
        }
    }
}
