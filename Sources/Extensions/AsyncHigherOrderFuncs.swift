// John Sundell (c)
// https://github.com/JohnSundell/CollectionConcurrencyKit/blob/main/Sources/CollectionConcurrencyKit.swift

// MARK: - ForEach
public extension Sequence {
    /// Run an async closure for each element within the sequence.
    ///
    /// The closure calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the closure calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter operation: The closure to run for each element.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncForEach(
            _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }

    /// Run an async closure for each element within the sequence.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter operation: The closure to run for each element.
    func concurrentForEach(
            withPriority priority: TaskPriority? = nil,
            _ operation: @Sendable @escaping (Element) async -> Void
    ) async where Element: Sendable {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask(priority: priority) {
                    await operation(element)
                }
            }
        }
    }

    /// Run an async closure for each element within the sequence.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed. If any of the closure calls throw an error,
    /// then the first error will be rethrown once all closure calls have
    /// completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter operation: The closure to run for each element.
    /// - throws: Rethrows any error thrown by the passed closure.
    func concurrentForEach(
            withPriority priority: TaskPriority? = nil,
            _ operation: @Sendable @escaping (Element) async throws -> Void
    ) async rethrows where Element: Sendable {
        try await withThrowingTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask(priority: priority) {
                    try await operation(element)
                }
            }

            // Propagate any errors thrown by the group's tasks:
            for try await _ in group {}
        }
    }
}

// MARK: - Map
public extension Sequence {
    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the closure calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncMap<T>(
            _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }

    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    func concurrentMap<T>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async -> T
    ) async -> [T] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                await transform(element)
            }
        }

        return await tasks.asyncMap { task in
            await task.value
        }
    }

    /// Transform the sequence into an array of new values using
    /// an async closure.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed. If any of the closure calls throw an error,
    /// then the first error will be rethrown once all closure calls have
    /// completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence.
    /// - throws: Rethrows any error thrown by the passed closure.
    func concurrentMap<T>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async throws -> T
    ) async rethrows -> [T] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                try await transform(element)
            }
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
}

// MARK: - CompactMap
public extension Sequence {
    /// Transform the sequence into an array of new values using
    /// an async closure that returns optional values. Only the
    /// non-`nil` return values will be included in the new array.
    ///
    /// The closure calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the closure calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   except for the values that were transformed into `nil`.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncCompactMap<T>(
            _ transform: (Element) async throws -> T?
    ) async rethrows -> [T] where T: Sendable {
        var values = [T]()

        for element in self {
            guard let value = try await transform(element) else {
                continue
            }

            values.append(value)
        }

        return values
    }

    /// Transform the sequence into an array of new values using
    /// an async closure that returns optional values. Only the
    /// non-`nil` return values will be included in the new array.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   except for the values that were transformed into `nil`.
    func concurrentCompactMap<T>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async -> T?
    ) async -> [T] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                await transform(element)
            }
        }

        return await tasks.asyncCompactMap { task in
            await task.value
        }
    }

    /// Transform the sequence into an array of new values using
    /// an async closure that returns optional values. Only the
    /// non-`nil` return values will be included in the new array.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed. If any of the closure calls throw an error,
    /// then the first error will be rethrown once all closure calls have
    /// completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   except for the values that were transformed into `nil`.
    /// - throws: Rethrows any error thrown by the passed closure.
    func concurrentCompactMap<T>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async throws -> T?
    ) async rethrows -> [T] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                try await transform(element)
            }
        }

        return try await tasks.asyncCompactMap { task in
            try await task.value
        }
    }
}

// MARK: - FlatMap
public extension Sequence {
    /// Transform the sequence into an array of new values using
    /// an async closure that returns sequences. The returned sequences
    /// will be flattened into the array returned from this function.
    ///
    /// The closure calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the closure calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   with the results of each closure call appearing in-order
    ///   within the returned array.
    /// - throws: Rethrows any error thrown by the passed closure.
    func asyncFlatMap<T: Sequence>(
            _ transform: (Element) async throws -> T
    ) async rethrows -> [T.Element] where T: Sendable {
        var values = [T.Element]()

        for element in self {
            try await values.append(contentsOf: transform(element))
        }

        return values
    }

    /// Transform the sequence into an array of new values using
    /// an async closure that returns sequences. The returned sequences
    /// will be flattened into the array returned from this function.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   with the results of each closure call appearing in-order
    ///   within the returned array.
    func concurrentFlatMap<T: Sequence>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async -> T
    ) async -> [T.Element] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                await transform(element)
            }
        }

        return await tasks.asyncFlatMap { task in
            await task.value
        }
    }

    /// Transform the sequence into an array of new values using
    /// an async closure that returns sequences. The returned sequences
    /// will be flattened into the array returned from this function.
    ///
    /// The closure calls will be performed concurrently, but the call
    /// to this function won't return until all of the closure calls
    /// have completed. If any of the closure calls throw an error,
    /// then the first error will be rethrown once all closure calls have
    /// completed.
    ///
    /// - parameter priority: Any specific `TaskPriority` to assign to
    ///   the async tasks that will perform the closure calls. The
    ///   default is `nil` (meaning that the system picks a priority).
    /// - parameter transform: The transform to run on each element.
    /// - returns: The transformed values as an array. The order of
    ///   the transformed values will match the original sequence,
    ///   with the results of each closure call appearing in-order
    ///   within the returned array.
    /// - throws: Rethrows any error thrown by the passed closure.
    func concurrentFlatMap<T: Sequence>(
            withPriority priority: TaskPriority? = nil,
            _ transform: @Sendable @escaping (Element) async throws -> T
    ) async rethrows -> [T.Element] where Element: Sendable, T: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                try await transform(element)
            }
        }

        return try await tasks.asyncFlatMap { task in
            try await task.value
        }
    }
}

// MARK: - AllSatisfy
public extension Sequence {
    /// Returns a Boolean value indicating whether every element of the sequence
    /// satisfies the given asynchronous predicate.
    ///
    /// The predicate calls will be performed in order, by waiting for
    /// each call to complete before proceeding with the next one. If
    /// any of the predicate calls throw an error, then the iteration
    /// will be terminated and the error rethrown.
    ///
    /// - parameter predicate: An asynchronous closure that takes an element of the sequence as its argument
    ///   and returns a Boolean value that indicates whether the passed element satisfies a condition.
    /// - returns: `true` if every element of the sequence satisfies the given predicate; otherwise, `false`.
    /// - throws: Rethrows any error thrown by the passed predicate.
    func asyncAllSatisfy(
        _ predicate: (Element) async throws -> Bool
    ) async rethrows -> Bool {
        for element in self {
            guard try await predicate(element) else {
                return false
            }
        }
        return true
    }

/// Returns a Boolean value indicating whether every element of the sequence
/// satisfies the given asynchronous predicate.
///
/// The predicate calls will be performed concurrently, but the call
/// to this function won't return until all of the predicate calls
/// have completed or until a `false` result is found.
///
/// - parameter priority: Any specific `TaskPriority` to assign to
///   the async tasks that will perform the predicate calls. The
///   default is `nil` (meaning that the system picks a priority).
/// - parameter predicate: An asynchronous closure that takes an element of the sequence as its argument
///   and returns a Boolean value that indicates whether the passed element satisfies a condition.
/// - returns: `true` if every element of the sequence satisfies the given predicate; otherwise, `false`.
    func concurrentAllSatisfy(
        withPriority priority: TaskPriority? = nil,
        _ predicate: @Sendable @escaping (Element) async -> Bool
    ) async -> Bool where Element: Sendable {
        await withTaskGroup(of: Bool.self) { group in
            for element in self {
                group.addTask(priority: priority) {
                    await predicate(element)
                }
            }

            for await result in group {
                if !result {
                    group.cancelAll()
                    return false
                }
            }

            return true
        }
    }


/// Returns a Boolean value indicating whether every element of the sequence
/// satisfies the given asynchronous predicate.
///
/// The predicate calls will be performed concurrently, but the call
/// to this function won't return until all of the predicate calls
/// have completed or until a `false` result is found. If any of the predicate calls throw an error,
/// then the first error will be rethrown once all predicate calls have completed.
///
/// - parameter priority: Any specific `TaskPriority` to assign to
///   the async tasks that will perform the predicate calls. The
///   default is `nil` (meaning that the system picks a priority).
/// - parameter predicate: An asynchronous closure that takes an element of the sequence as its argument
///   and returns a Boolean value that indicates whether the passed element satisfies a condition.
/// - returns: `true` if every element of the sequence satisfies the given predicate; otherwise, `false`.
/// - throws: Rethrows any error thrown by the passed predicate.
    func concurrentAllSatisfy(
        withPriority priority: TaskPriority? = nil,
        _ predicate: @Sendable @escaping (Element) async throws -> Bool
    ) async rethrows -> Bool where Element: Sendable {
        try await withThrowingTaskGroup(of: Bool.self) { group in
            for element in self {
                group.addTask(priority: priority) {
                    try await predicate(element)
                }
            }

            for try await result in group {
                if !result {
                    group.cancelAll()
                    return false
                }
            }

            return true
        }
    }
}

// MARK: - Filter
public extension Sequence {
/// Filter the sequence using an async predicate.
///
/// The predicate calls will be performed in order, by waiting for
/// each call to complete before proceeding with the next one. If
/// any of the predicate calls throw an error, then the iteration
/// will be terminated and the error rethrown.
///
/// - parameter isIncluded: The predicate to run on each element.
/// - returns: An array containing only the elements that satisfy the given predicate.
/// - throws: Rethrows any error thrown by the passed predicate.
    func asyncFilter(
        _ isIncluded: (Element) async throws -> Bool
    ) async rethrows -> [Element] {
        var result = [Element]()

        for element in self {
            if try await isIncluded(element) {
                result.append(element)
            }
        }

        return result
    }

/// Filter the sequence using an async predicate.
///
/// The predicate calls will be performed concurrently, but the call
/// to this function won't return until all of the predicate calls
/// have completed.
///
/// - parameter priority: Any specific `TaskPriority` to assign to
///   the async tasks that will perform the predicate calls. The
///   default is `nil` (meaning that the system picks a priority).
/// - parameter isIncluded: The predicate to run on each element.
/// - returns: An array containing only the elements that satisfy the given predicate.
    func concurrentFilter(
        withPriority priority: TaskPriority? = nil,
        _ isIncluded: @Sendable @escaping (Element) async -> Bool
    ) async -> [Element] where Element: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                await (element, isIncluded(element))
            }
        }

        return await tasks.asyncFilter { task in
            let (_, included) = await task.value
            return included
        }.asyncMap { task in
            let (element, _) = await task.value
            return element
        }
    }

/// Filter the sequence using an async predicate.
///
/// The predicate calls will be performed concurrently, but the call
/// to this function won't return until all of the predicate calls
/// have completed. If any of the predicate calls throw an error,
/// then the first error will be rethrown once all predicate calls have
/// completed.
///
/// - parameter priority: Any specific `TaskPriority` to assign to
///   the async tasks that will perform the predicate calls. The
///   default is `nil` (meaning that the system picks a priority).
/// - parameter isIncluded: The predicate to run on each element.
/// - returns: An array containing only the elements that satisfy the given predicate.
/// - throws: Rethrows any error thrown by the passed predicate.
    func concurrentFilter(
        withPriority priority: TaskPriority? = nil,
        _ isIncluded: @Sendable @escaping (Element) async throws -> Bool
    ) async rethrows -> [Element] where Element: Sendable {
        let tasks = map { element in
            Task(priority: priority) {
                try await (element, isIncluded(element))
            }
        }

        return try await tasks.asyncFilter { task in
            let (_, included) = try await task.value
            return included
        }.asyncMap { task in
            let (element, _) = try await task.value
            return element
        }
    }
}
