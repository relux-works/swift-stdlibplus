public final class ActorEntrancy {
    private let semaphore = AsyncSemaphore(value: 1)

    public init() {
    }

    public func enter() async {
        await semaphore.wait()
    }
    public func leave() {
        semaphore.signal()
    }
}
