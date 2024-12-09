import Foundation

public struct UncheckedSendableWrapper<T>: @unchecked Sendable {
    public let payload: T

    public init(payload: T) {
        self.payload = payload
    }
}
