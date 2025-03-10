// foreach
public extension AsyncSequence {
    func forEach(
        _ action: @escaping (Self.Element) throws -> Void
    ) async rethrows -> Void {
        for try await item in self {
            try action(item)
        }
    }

    func forEach(
        _ action: @escaping (Self.Element) async throws -> Void
    ) async rethrows -> Void {
        for try await item in self {
            try await action(item)
        }
    }
}
