import Foundation

public extension Error {
    var asString: String {
        "\(self) - \(self.localizedDescription)"
    }
}

