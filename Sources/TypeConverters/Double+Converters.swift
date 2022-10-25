#if canImport(Darwin)
import Darwin

public extension Double {
    var asFloat: Float {
        Float(self)
    }

    var asIntRounded: Int {
        Int(lround(self))
    }

    var asUIntRounded: UInt {
        Int(lround(self)).asUInt
    }
    
    var asUIntTruncated: UInt {
        UInt(self)
    }
    
    var asInt: Int {
        Int(self)
    }
}

#endif
