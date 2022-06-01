import Foundation

public enum ValueRange<T: Codable & Comparable>: Codable {
    case closed(bounds: Range<T>)
    case partialFrom(startBound: PartialRangeFrom<T>)
    case partialTo(endBound: PartialRangeUpTo<T>)
}

public extension ValueRange {
    func contains(_ value: T) -> Bool {
        switch self {
        case let .closed(r): return r.contains(value)
        case let .partialFrom(r): return r.contains(value)
        case let .partialTo(r): return r.contains(value)
        }
    }
}