import Foundation

//struct Prerequisite: OptionSet, Codable, Hashable, Sequence {
//    var rawValue: Int
//    static let camera: Prerequisite = .init(rawValue: 1)
//    static let chargedDevice: Prerequisite = .init(rawValue: 2)
//    static let normalPowerMode: Prerequisite = .init(rawValue: 4)
//
//    static let all: Prerequisite = [.camera, .chargedDevice, .normalPowerMode]
//}

public struct OptionSetIterator<Element: OptionSet>: IteratorProtocol where Element.RawValue == Int {
    private let value: Element

    public init(element: Element) {
        self.value = element
    }

    private lazy var remainingBits = value.rawValue
    private var bitMask = 1

    public mutating func next() -> Element? {
        while remainingBits != 0 {
            defer { bitMask = bitMask &* 2 }
            if remainingBits & bitMask != 0 {
                remainingBits = remainingBits & ~bitMask
                return Element(rawValue: bitMask)
            }
        }
        return nil
    }
}

extension OptionSet where Self.RawValue == Int {
    public func makeIterator() -> OptionSetIterator<Self> {
        return OptionSetIterator(element: self)
    }
}