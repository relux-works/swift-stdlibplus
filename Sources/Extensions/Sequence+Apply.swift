public extension Sequence where Element: Any {
    @discardableResult
    func apply(_ closure: @Sendable (Self)->()) -> Self {
        closure(self)
        return self
    }

    @discardableResult
    func apply(_ closure: @Sendable (Self)async ->()) async -> Self {
        await closure(self)
        return self
    }
}
