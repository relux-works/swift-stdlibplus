import Foundation

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

// compactMap
public extension AsyncSequence {
    func compactMap<Transformed>(
        _ transform: @escaping (Self.Element) throws -> Transformed?
    ) rethrows -> AsyncStream<Transformed> {
        AsyncStream<Transformed> { continuation in
            Task {
                for try await element in self {
                    guard let transformed = try transform(element)
                    else { continue }
                    continuation.yield(transformed)
                }
                continuation.finish()
            }
        }
    }

    func compactMap<Transformed>(
        _ transform: @escaping (Self.Element) async throws -> Transformed?
    ) rethrows -> AsyncStream<Transformed> {
        AsyncStream<Transformed> { continuation in
            Task {
                for try await element in self {
                    guard let transformed = try await transform(element)
                    else { continue }
                    continuation.yield(transformed)
                }
                continuation.finish()
            }
        }
    }
}


// map
public extension AsyncSequence {
    func map<Transformed>(
        _ transform: @escaping (Self.Element) throws -> Transformed
    ) rethrows -> AsyncStream<Transformed> {
        AsyncStream<Transformed> { continuation in
            Task {
                for try await element in self {
                    continuation.yield(try transform(element))
                }
                continuation.finish()
            }
        }
    }

    func map<Transformed>(
        _ transform: @escaping (Self.Element) async throws -> Transformed
    ) rethrows -> AsyncStream<Transformed> {
        AsyncStream<Transformed> { continuation in
            Task {
                for try await element in self {
                    continuation.yield(try await transform(element))
                }
                continuation.finish()
            }
        }
    }
}
