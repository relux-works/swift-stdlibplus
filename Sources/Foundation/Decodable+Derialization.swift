import Foundation

public extension Decodable {
    static func decode(from data: Data?) -> Self? {
        guard let data = data else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
