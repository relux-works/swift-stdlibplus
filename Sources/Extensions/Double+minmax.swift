public extension Double {
    func minmax(in range: ClosedRange<Double>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
