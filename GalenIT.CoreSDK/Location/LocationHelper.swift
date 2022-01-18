import Foundation

public struct LocationHelper {

    public static let defaultLocationIso: String = "US"
    
    public static var cellularLocaleIso: String? {
        CellularNetworkHelper.getCurrentProviderInfo()?.isoCountryCode
    }
    
    public static var deviceLocaleIso: String? {
        guard
            let iso = Locale.current.regionCode,
            iso.isNotEmpty
        else {
            return nil
        }
        
        return iso
    }

    public static var currentLocationIso: String {
        cellularLocaleIso ?? deviceLocaleIso ?? defaultLocationIso
    }
}
