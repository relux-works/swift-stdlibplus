import Foundation

public extension Int {
    var asPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        let number = NSNumber(value: self)
        return formatter.string(from: number)!
    }

    var asRuPrice: String {
        let number = NSNumber(value: self)

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."

        switch self.description.count % 3 {
            case 1: formatter.groupingSeparator = ""
            case 0, 2: formatter.groupingSeparator = " "
            default: formatter.groupingSeparator = " "
        }

        return formatter.string(from: number)!
    }
}
