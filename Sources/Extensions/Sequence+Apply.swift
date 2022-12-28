public extension Sequence where Element: Any {
    func apply(_ closure: (Self)->()) -> Self {
        closure(self)
        return self
    }

	@discardableResult
    func apply(_ closure: (Self)async ->()) async -> Self {
        await closure(self)
        return self
    }
}
