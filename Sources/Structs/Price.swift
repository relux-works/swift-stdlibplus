import Foundation

public struct Price<C: ICurrency> {
    public let value: Double
    public let currency: C

    public init(
        value: Double,
        currency: C
    ) {
        self.value = value
        self.currency = currency
    }
}

public extension Price {
    var formattedValue: String {
        String(format: "%.02f", value)
    }

    var priceRuWithCurrencyRoundedUp: String {
        value.rounded(.up).asIntRounded.asRuPrice + " " + currency.symbol
    }

    var priceWithCurrencyRoundedUp: String {
        value.rounded(.up).asIntRounded.asPrice + " " + currency.symbol
    }
}

public protocol ICurrency {
    var symbol: String { get }
    var ticker: String { get }
}

public enum Currency: ICurrency {
    case rub

    public var symbol: String {
        switch self {
        case .rub: return "₽"
        }
    }

    public var ticker: String {
        switch self {
        case .rub: return "RUB"
        }
    }
}
