public extension String {
    static let nbsp = "\u{00A0}"

    var nbsp: String {
        "\(self)\(String.nbsp)"
    }
}
