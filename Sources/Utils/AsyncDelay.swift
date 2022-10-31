public func delay(for delayTime: Double?, action: @escaping  () async -> Void) async {
    let delay = UInt64((delayTime ?? 0.0) * 1_000_000_000)
    do {
        try await Task<Never, Never>.sleep(nanoseconds: delay)
        await action()
    } catch {
        print(error)
    }
}
