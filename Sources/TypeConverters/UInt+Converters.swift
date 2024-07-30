public extension UInt {
	/// Custom error type for conversion errors
	enum ConversionError: Error {
		case overflow
		
		public var errorDescription: String? {
			switch self {
				case .overflow:
					return "UInt value exceeds Int range."
			}
		}
	}
	
	/// Converts the unsigned integer (UInt) to a Double.
	/// - Returns: A Double representation of the unsigned integer.
	var asDouble: Double {
		Double(self)
	}
	
	/// Converts the unsigned integer (UInt) to an Int.
	/// - Note: This conversion is safe as long as the value of the UInt is within
	///   the range of valid Int values. If the UInt value exceeds the maximum Int value,
	///   it may cause an overflow and result in unexpected behavior.
	/// - Returns: An Int representation of the unsigned integer.
	@available(*, deprecated, message: "Use 'asIntOrThrow()' instead for a throwing conversion.")
	var asInt: Int {
		Int(self)
	}
	
	/// Safely converts the unsigned integer (UInt) to an Int.
	/// - Throws: A `ConversionError.overflow` if the UInt value exceeds the range of valid Int values.
	/// - Returns: An Int representation of the unsigned integer.
	func asIntOrThrow() throws -> Int {
		if self > UInt(Int.max) {
			throw ConversionError.overflow
		}
		return Int(self)
	}
}
