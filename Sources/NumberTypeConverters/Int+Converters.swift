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
        switch self {
        case ...0: return 0
        default: return UInt(self)
        }
    }
}

public extension Int64 {
    var asDouble: Double {
        Double(self)
    }

    var asCGFloat: CGFloat {
        CGFloat(self)
    }

    var asUInt: UInt {
        switch self {
        case ...0: return 0
        default: return UInt(self)
        }
    }
}
