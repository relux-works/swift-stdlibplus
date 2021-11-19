import Foundation

public struct ApiEndpoint {
    public let path: String
    public let type: ApiRequestType
    
    public init(
        path: String,
        type: ApiRequestType
    ) {
        self.path = path
        self.type = type
    }
}
