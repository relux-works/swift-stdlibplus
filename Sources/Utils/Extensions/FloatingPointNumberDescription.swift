import Foundation
import CoreGraphics

@available(iOS 15, macOS 12, *)
public extension Double {
    func stringDescription(
        minimumIntegerDigits: Int = 1,
        fractionDigits: Int = 2,
        includeSignStrategy: FloatingPointFormatStyle<Double>.Configuration.SignDisplayStrategy = .automatic
    ) -> String {
        self.formatted(
            .number
                .sign(strategy: includeSignStrategy)
                .precision(
                    .integerAndFractionLength(
                        integerLimits: minimumIntegerDigits...,
                        fractionLimits: fractionDigits...fractionDigits
                    )
                )
        )
    }
    var stringDescription: String {
        self.formatted(
            .number
                .sign(strategy: .automatic)
                .precision(
                    .integerAndFractionLength(
                        integerLimits: 1...,
                        fractionLimits: 2...2
                    )
                )
        )
    }

}

@available(iOS 15, macOS 12, *)
public extension Float {
    func stringDescription(
        minimumIntegerDigits: Int = 1,
        fractionDigits: Int = 2,
        includeSignStrategy: FloatingPointFormatStyle<Double>.Configuration.SignDisplayStrategy = .automatic
    ) -> String {
        self.formatted(
            .number
                .sign(strategy: includeSignStrategy)
                .precision(
                    .integerAndFractionLength(
                        integerLimits: minimumIntegerDigits...,
                        fractionLimits: fractionDigits...fractionDigits
                    )
                )
        )
    }
    var stringDescription: String {
        self.formatted(
            .number
                .sign(strategy: .automatic)
                .precision(
                    .integerAndFractionLength(
                        integerLimits: 1...,
                        fractionLimits: 2...2
                    )
                )
        )
    }
}

@available(iOS 15, macOS 12, *)
public extension CGFloat {
    func stringDescription(
        minimumIntegerDigits: Int = 1,
        fractionDigits: Int = 2,
        includeSignStrategy: FloatingPointFormatStyle<Double>.Configuration.SignDisplayStrategy = .automatic
    ) -> String {
        let selfAsFloat = Float(self)
        return selfAsFloat.stringDescription(
            minimumIntegerDigits: minimumIntegerDigits,
            fractionDigits: fractionDigits,
            includeSignStrategy: includeSignStrategy
        )
    }
    
    var stringDescription: String {
        let selfAsFloat = Float(self)
        return selfAsFloat.stringDescription(
            minimumIntegerDigits: 1,
            fractionDigits: 2,
            includeSignStrategy: .automatic
        )
    }
}
