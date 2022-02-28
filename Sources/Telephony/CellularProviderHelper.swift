import Foundation
import CoreTelephony

public struct CellularNetworkHelper {
    private static let networkInfo = CTTelephonyNetworkInfo()

    public static func getCurrentProviderInfo() -> CellularNetworkInfo? {
        guard
                let providers = networkInfo.serviceSubscriberCellularProviders,
                let currentProviderId = networkInfo.dataServiceIdentifier,
                let currentProvider = providers[currentProviderId],
                let isoCountryCode = currentProvider.isoCountryCode,
                isoCountryCode.isNotEmpty
        else {
            return nil
        }
        return .init(
                carrierName: currentProvider.carrierName ?? "",
                isoCountryCode: isoCountryCode.uppercased(),
                mobileCountryCode: currentProvider.mobileCountryCode ?? "",
                mobileNetworkCode: currentProvider.mobileNetworkCode ?? "",
                allowsVOIP: currentProvider.allowsVOIP
        )
    }
}
