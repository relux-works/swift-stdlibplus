public extension Array where Element: BinaryFloatingPoint {
    var average: Double? {
        if self.isEmpty {
            return nil
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
}
