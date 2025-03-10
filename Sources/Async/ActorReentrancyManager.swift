public final class ActorReentrancyManager: @unchecked Sendable {
	private let lock = AsyncLock()
	
	public init() {}
	
    @Sendable
    public func performProtected<T: Sendable>(_ work: @Sendable () async throws -> T) async rethrows -> T {
		try await lock.withLock {
			try await work()
		}
	}
}
