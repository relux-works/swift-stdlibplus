import Foundation

public extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}


extension Decodable {
    init?(json: Data?) {
        if json != nil,
           let instance = Self.decode(from: json) {
            self = instance
        } else {
            return nil
        }
    }
}
