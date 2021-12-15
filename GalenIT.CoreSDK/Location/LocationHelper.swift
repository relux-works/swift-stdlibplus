import Foundation

public struct LocationHelper {

    public static let defaultLocationIso: Country.Iso = Country.Iso(rawValue: "US")
    
    public static var cellularLocaleIso: Country.Iso? {
        CellularNetworkHelper.getCurrentProviderInfo()?.isoCountryCode
    }
    
    public static var deviceLocaleIso: Country.Iso? {
        guard
            let iso = Locale.current.regionCode,
            iso.isNotEmpty
        else {
            return nil
        }
        
        return Country.Iso(rawValue: iso)
    }

    public static var currentLocationIso: Country.Iso {
        cellularLocaleIso ?? deviceLocaleIso ?? defaultLocationIso
    }
}
