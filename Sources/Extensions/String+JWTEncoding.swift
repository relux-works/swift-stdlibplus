import Foundation

extension String {
    public var jwtAsPropertyMap: [String: Any] {
        let segments = self.components(separatedBy: ".")
        return segments[safe: 1]?.decodedJWTPart ?? [:]
    }

    public var jwtAsDecodedData: Data? {
        let segments = self.components(separatedBy: ".")
        return segments[safe: 1]?.jwtPartAsDecodedData
    }


    private var decodedJWTPart: [String: Any]? {
        guard let bodyData = self.jwtPartAsDecodedData,
              let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
            return nil
        }

        return payload
    }

    private var jwtPartAsDecodedData: Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 = base64 + padding
        }

        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
}
