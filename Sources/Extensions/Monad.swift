public struct Monad<T> {
    public let value : T

    @inlinable @inline(__always)
    public init(_ value : T) {
        self.value = value
    }

    @inlinable @inline(__always)
    public func apply<G>(
        _ transform : @escaping (T)throws->G
    ) rethrows -> Monad<G> {
        let transformed = try transform(self.value)
        return Monad<G>(transformed)
    }

    @inlinable @inline(__always)
    public func apply<G>(
        _ transformer: @escaping (T)async throws->G
    ) async rethrows -> Monad<G> {
        let transformed = try await transformer(self.value)
        return Monad<G>(transformed)
    }

    @discardableResult
    @inlinable @inline(__always)
    public func also(
        perform : @escaping (T)throws->(),
        when condition: ((T)throws->Bool)? = nil,
        otherwise performElse: ((T)throws->())? = nil
    ) rethrows -> Self {
        if try condition?(self.value) ?? true {
            try perform(self.value)
        } else {
            try performElse?(self.value)
        }

        return self
    }

    @discardableResult
    @inlinable @inline(__always)
    public func also(
        perform : @escaping (T)async throws->(),
        when condition: ((T)throws->Bool)? = nil,
        otherwise performElse: ((T)async throws->())? = nil
    ) async rethrows -> Self {
        if try condition?(self.value) ?? true {
            try await perform(self.value)
        } else {
            try await performElse?(self.value)
        }

        return self
    }

    @discardableResult
    @inlinable @inline(__always)
    public func also(
        perform : @escaping (T)async throws ->(),
        when condition: ((T)async throws->Bool)? = nil,
        otherwise performElse: ((T)async throws ->())? = nil
    ) async rethrows -> Self {
        if (try await condition?(self.value)) ?? true {
            try await perform(self.value)
        } else {
            try await performElse?(self.value)
        }

        return self
    }
}

public protocol Monadable {}

public extension Monadable {
    var monad: Monad<Self> { Monad(self) }
}

public extension Sequence {
    var monad: Monad<Self> { Monad(self) }
}

public extension Dictionary {
    var monad: Monad<Self> { Monad(self) }
}
