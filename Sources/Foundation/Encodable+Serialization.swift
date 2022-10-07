import Foundation

public extension Encodable {
    var asJsonData: Data? {
        return try? JSONEncoder().encode(self)
    }
}

