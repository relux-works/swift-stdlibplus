public protocol Weighable {
    var weight: Double { get }
}

public protocol Valuable {
    associatedtype Value: BinaryFloatingPoint
    var value: Value { get }
}

public extension Collection where Element: Valuable & Weighable {
    var average: Double? {
        if self.isEmpty {
            return nil
        } else {
            let sum = self.reduce(Double(), { result, next in
                result + (Double(next.value) * next.weight)
            })
            let divider = self.reduce(Double(), { result, next in
                result + next.weight
            })
            return sum / divider
        }
    }
}
