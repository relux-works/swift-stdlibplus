import Foundation

public struct Size<T: Codable & FixedWidthInteger>: Codable {
    public let width: T
    public let height: T

    public init(
            width: T,
            height: T
    ) {
        self.width = width
        self.height = height
    }

    public var area: T {
        width * height
    }
}