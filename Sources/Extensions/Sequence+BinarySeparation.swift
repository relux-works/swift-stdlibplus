import Foundation

extension Sequence {
    @inlinable public func separate(by expression: (Self.Element) throws -> Bool) rethrows -> (positive: [Self.Element], negative: [Self.Element]) {
        var result: (
            positive: [Self.Element],
            negative: [Self.Element]
        ) = (positive: [], negative: [])

        try self.forEach {
            switch try expression($0) {
            case true: result.positive.append($0)
            case false: result.negative.append($0)
            }
        }

        return result
    }
}