import Foundation

public extension Encodable {
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
}

