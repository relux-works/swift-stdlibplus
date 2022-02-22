import Foundation

@discardableResult
public func measure(_ action: () -> ()) -> Int64 {
    let start = Date().toMillis
    action()
    let end = Date().toMillis
    return end - start
}
