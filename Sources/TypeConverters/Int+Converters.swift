public extension Int {
	/// Converts the integer to a Double.
	/// - Returns: A Double representation of the integer.
	var asDouble: Double {
		Double(self)
	}
	
	/// Converts the integer to an unsigned integer (UInt).
	/// - Note: If the integer is negative, it will be converted to 0.
	///   This ensures that no negative values are converted to UInt, preventing unexpected large values.
	/// - Returns: A UInt representation of the integer, or 0 if the integer is negative.
	var asUInt: UInt {
		switch self {
			case ...0: return 0
			default: return UInt(self)
		}
	}
}

public extension Int64 {
	/// Converts the 64-bit integer to a Double.
	/// - Returns: A Double representation of the 64-bit integer.
	var asDouble: Double {
		Double(self)
	}
	
	/// Converts the 64-bit integer to an unsigned integer (UInt).
	/// - Note: If the 64-bit integer is negative, it will be converted to 0.
	///   This ensures that no negative values are converted to UInt, preventing unexpected large values.
	/// - Returns: A UInt representation of the 64-bit integer, or 0 if the integer is negative.
	var asUInt: UInt {
		switch self {
			case ...0: return 0
			default: return UInt(self)
		}
	}
}
