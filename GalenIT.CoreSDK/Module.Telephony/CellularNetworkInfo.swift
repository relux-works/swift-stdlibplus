import Foundation

public struct CellularNetworkInfo {
    public let carrierName: String
    public let isoCountryCode: Country.Iso
    public let mobileCountryCode: String
    public let mobileNetworkCode: String
    public let allowsVOIP: Bool
}
