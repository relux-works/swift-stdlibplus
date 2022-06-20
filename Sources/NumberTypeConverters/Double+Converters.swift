import SwiftUI

public extension CGFloat {
    init?(_ val: Double?) {
        guard let v = val else { return nil }
        self = v
    }
}

public extension Double {
    var asCGFloat: CGFloat {
        CGFloat(self)
    }
    var asFloat: Float {
        Float(self)
    }

    var asIntRounded: Int {
        Int(lround(self))
    }
    
    var asUIntTruncated: UInt {
        UInt(self)
    }
    
    var asInt: Int {
        Int(self)
    }
}
