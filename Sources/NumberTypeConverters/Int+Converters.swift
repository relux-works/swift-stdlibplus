import Foundation
import SwiftUI

public extension Int {
    var asDouble: Double {
        Double(self)
    }

    var asCGFloat: CGFloat {
        CGFloat(self)
    }

    var asUInt: UInt {
        UInt(self)
    }
}