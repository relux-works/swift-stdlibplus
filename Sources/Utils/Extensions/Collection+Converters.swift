import Foundation

public extension Collection where Element: Hashable {
    var asSet: Set<Element> {
        Set(self)
    }
}