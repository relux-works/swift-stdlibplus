import Foundation

public struct SecureStoreError: IAppError {
    public let violation: ErrorViolation
    public let sender: Any.Type
    public let message: String
    public let callStack: [String]
    public let error: Error?

    public var conciseDescription: String {
        "\(sender): \(violation) from \(sender); \(message)"
    }

    public var description: String {
        conciseDescription
    }

    public var debugDescription: String {
        conciseDescription
    }

    public init(
            sender: Any,
            message: String = "",
            violation: ErrorViolation = .warning,
            error: Error? = nil
    ) {
        self.sender = Mirror(reflecting: sender).subjectType
        self.message = message
        self.violation = violation
        self.callStack = Thread.callStackSymbols
        self.error = error
    }

    public func toString() -> String {
        data.map { "\($0.key): \($0.value)" }.joined(separator: "\n");
    }

    public var data: [String: String] {
        [
            "sender": "\(sender)",
            "message": message,
            "violation": violation.rawValue,
            "cause": error?.localizedDescription ?? "",
            "callStack": "\n\(callStack.joined(separator: "\n"))"
        ]
    }
}
