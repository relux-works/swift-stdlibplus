import Foundation

public struct ApiError: IAppError {
    public let violation: ErrorViolation
    public let sender: Any.Type
    public let message: String
    public let rawData: Data?
    public let callStack: [String]
    public let error: Error?
    public let url: String
    public let responseCode: Int
    public let requestType: ApiRequestType
    public let headers: [HeaderKey: HeaderValue]
    public let params: [ParamKey: ParamValue]

    public var conciseDescription: String {
        "\(responseCode): \(violation) from \(sender); \(message)"
    }

    public var description: String {
        conciseDescription
    }

    public var debugDescription: String {
        conciseDescription
    }
    
    public init(
            sender: Any,
            endpoint: ApiEndpoint,
            responseCode: Int = 0,
            message: String = "",
            data: Data? = nil,
            violation: ErrorViolation = .warning,
            error: Error? = nil,
            headers: [HeaderKey: HeaderValue] = [:],
            params: [ParamKey: ParamValue] = [:]
    ) {
        self.init(
                sender: sender,
                url: endpoint.path,
                responseCode: responseCode,
                message: message,
                data: data,
                violation: violation,
                error: error,
                requestType: endpoint.type,
                headers: headers,
                params: params
        )
    }

    public init(
            sender: Any,
            url: String = "",
            responseCode: Int = 0,
            message: String = "",
            data: Data? = nil,
            violation: ErrorViolation = .warning,
            error: Error? = nil,
            requestType: ApiRequestType,
            headers: [HeaderKey: HeaderValue] = [:],
            params: [ParamKey: ParamValue] = [:]
    ) {
        self.sender = Mirror(reflecting: sender).subjectType
        self.url = url
        self.responseCode = responseCode
        self.message = message
        self.rawData = data
        self.violation = violation
        self.callStack = Thread.callStackSymbols
        self.headers = headers
        self.params = params
        self.error = error
        self.requestType = requestType
    }

    public func toString() -> String {
        data.map { "\($0.key): \($0.value)" }.joined(separator: "\n");
    }

    public var data: [String: String] {
        [
            "sender": "\(sender)",
            "url": url,
            "type": "\(requestType.rawValue)",
            "responseCode": "\(responseCode)",
            "message": message,
            "violation": violation.rawValue,
            "cause": error?.localizedDescription ?? "",
            "callStack": "\n\(callStack.joined(separator: "\n"))"
        ]
    }
}
