extension Sequence {
    public func whenAll(satisfy predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        try self.contains(where: { try predicate($0).not }).not
    }
}
