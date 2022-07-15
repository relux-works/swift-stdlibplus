import Foundation

extension Equatable {
    @inlinable public func contained(in elements: [Self]) -> Bool {
        elements.contains(self)
    }

    @inlinable public func contained(in elements: Set<Self>) -> Bool where Self: Hashable & Equatable {
        elements.contains(self)
    }
}