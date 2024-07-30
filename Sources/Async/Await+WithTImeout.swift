import Foundation

public struct TimedOutError: Error, Equatable {}

/// Runs an async task with a timeout.
///
/// - Parameters:
///   - maxDuration: The duration in seconds `work` is allowed to run before timing out.
///   - work: The async operation to perform.
/// - Returns: Returns the result of `work` if it completed in time.
/// - Throws: Throws ``TimedOutError`` if the timeout expires before `work` completes.
///   If `work` throws an error before the timeout expires, that error is propagated to the caller.
public func `async`<R>(
    timeoutAfter maxDuration: TimeInterval,
    do work: @escaping () async throws -> R
) async throws -> R {
    try await withThrowingTaskGroup(of: R.self) { group in
        // Start timeout child task.
        group.addTask {
            let delay = UInt64(maxDuration * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            try Task.checkCancellation()
            throw TimedOutError()
        }

        // Start actual work.
        group.addTask {
            try await work()
        }

        // First finished child task wins, cancel the other task.
        let result = try await group.next()!
        group.cancelAll()
        return result
    }
}