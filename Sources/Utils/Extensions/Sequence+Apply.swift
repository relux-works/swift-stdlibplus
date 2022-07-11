import Foundation

public extension Sequence where Element: Any {
    func apply(_ closure: (Self)->()) -> Self {
        closure(self)
        return self
    }
}