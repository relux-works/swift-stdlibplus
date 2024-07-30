
public final class ActorReentrancyManager {
	private let lock = AsyncLock()
	
	public init() {}
	
	public func performProtected<T>(_ work: () async throws -> T) async rethrows -> T {
		try await lock.withLock {
			try await work()
		}
	}
}
