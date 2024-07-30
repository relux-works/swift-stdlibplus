#if canImport(Darwin)
import Darwin
#elseif os(Linux)
import Glibc
#elseif os(Windows)
import ucrt
#else
#error("Unsupported platform")
#endif

public extension Double {
	/// Converts the double to a Float.
	var asFloat: Float {
		Float(self)
	}
	
	/// Rounds the double to the nearest integer and converts it to an Int.
	/// - Note: Rounding follows the "round half to even" rule, also known as banker's rounding.
	///   This means that if the double is exactly halfway between two integers, it will round
	///   to the nearest even number. For example, 2.5 rounds to 2, and 3.5 rounds to 4.
	var asIntRounded: Int {
		Int(lround(self))
	}
	
	/// Rounds the double to the nearest integer and converts it to a UInt.
	/// - Note: Rounding follows the "round half to even" rule, also known as banker's rounding.
	///   This means that if the double is exactly halfway between two integers, it will round
	///   to the nearest even number. For example, 2.5 rounds to 2, and 3.5 rounds to 4.
	///   **Be cautious with negative values, as they will be converted to a UInt after rounding,
	///   which may result in unexpected large values**.
	var asUIntRounded: UInt {
		UInt(lround(self))
	}
	
	/// Truncates the double to an unsigned integer (UInt).
	/// - Note: This conversion truncates the fractional part of the double, simply discarding it.
	///   For example, 3.9 becomes 3. If the double is negative, it will be converted directly
	///   to UInt, which can lead to unexpected large values.
	var asUIntTruncated: UInt {
		UInt(self)
	}
	
	/// Converts the double to an Int, truncating any fractional part.
	/// - Note: This conversion simply discards the fractional part of the double.
	///   For example, 3.9 becomes 3 and -3.9 becomes -3.
	var asInt: Int {
		Int(self)
	}
}
