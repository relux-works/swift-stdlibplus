public extension String {
	/// Converts the string to an optional integer (Int).
	/// - Returns: An optional Int representation of the string. If the string
	///   cannot be converted to an Int (e.g., it contains non-numeric characters),
	///   the result will be nil.
	var asInt: Int? {
		Int(self)
	}
}
