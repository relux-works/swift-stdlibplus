import Foundation

extension Equatable {
    @inlinable public func contained(in elements: [Self]) -> Bool {
        elements.contains(self)
    }
}