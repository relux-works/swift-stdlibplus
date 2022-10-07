import Foundation

public extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}


public extension Decodable {
    init?(fromJsonData: Data?) {
        if fromJsonData != nil,
           let instance = Self.decode(from: fromJsonData) {
            self = instance
        } else {
            return nil
        }
    }
}
