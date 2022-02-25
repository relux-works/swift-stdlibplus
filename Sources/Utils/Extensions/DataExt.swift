import Foundation


public extension Data {
    
    /// just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8) }
}

public extension Data {
    
    /// Converts data to a hexadecimal string.
    ///
    /// - Returns
    ///   a hexadecimal representation of the underlying data; empty data results in empty string.
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

public extension Data {
    /// Constructs a data container from base64 string. String's base64 padding is
    /// evaluated and fixed if needed.
    init?(base64EncodedPadded string: String, options: Data.Base64DecodingOptions = []) {
        func padded(_ value: String) -> String {
            var base64 = value
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            let length = Double(base64.lengthOfBytes(using: .utf8))
            let requiredLength = 4 * ceil(length / 4.0)
            let paddingLength = requiredLength - length
            if paddingLength > 0 {
                let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
                base64 = base64 + padding
            }
            return base64
        }
        self.init(base64Encoded: padded(string), options: .ignoreUnknownCharacters)
    }
}

public extension Array where Element == UInt8 {
    
    /// Converts a and array of bytes to a hexadecimal string
    ///
    /// - Returns
    ///   a hexadecimal representation of the underlying byte array; empty array results in empty string.
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
