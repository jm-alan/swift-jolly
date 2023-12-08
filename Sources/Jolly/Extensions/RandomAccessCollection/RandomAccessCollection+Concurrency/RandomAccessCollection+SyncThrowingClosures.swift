import Foundation

public extension RandomAccessCollection {
    /// Splits the collection into `maxConcurrentDivisions` pieces, defaulting to
    /// `ProcessInfo.processInfo.activeProcessorCount` slices, and runs the provided closure
    /// concurrently on each slice.
    ///
    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure.
    @inlinable
    @inline(__always)
    func concurrentForEach(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ body: @escaping (Element) throws -> Void
    ) async throws {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )

        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        try await withThrowingTaskGroup(of: Void.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try self[safe: stableCurrentIndex..<nextIndex].forEach(body)
                }
                currentIndex = nextIndex
            }

            try await taskGroup.waitForAll()
        }
    }

    /// Splits the collection into `maxConcurrentDivisions` pieces, defaulting to
    /// `ProcessInfo.processInfo.activeProcessorCount` slices, and runs the provided closure
    /// concurrently on each slice, before concatenating the slices back together in order.
    ///
    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure, only the order of the elements in the resulting collection.
    @inlinable
    @inline(__always)
    func concurrentMap<T>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping (Element) throws -> T
    ) async throws -> [T] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )

        var (divisionLength, rem) = count.quotientAndRemainder(dividingBy: divisions)
        divisionLength += Swift.min(rem, 1)

        return try await withThrowingTaskGroup(of: (Index, [T]).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)

                taskGroup.addTask {
                    try (
                        stableCurrentIndex,
                        self[safe: stableCurrentIndex..<nextIndex].map(transform)
                    )
                }

                currentIndex = nextIndex
            }

            var initialResult = try await taskGroup.reduce(into: []) { $0.append($1) }
            initialResult.sort { $0.0 < $1.0 }

            return initialResult.reduce(into: []) { $0.append(contentsOf: $1.1) }
        }
    }

    /// Splits the collection into `maxConcurrentDivisions` pieces, defaulting to
    /// `ProcessInfo.processInfo.activeProcessorCount` slices, and runs the provided closure
    /// concurrently on each slice, before concatenating the slices back together in order.
    ///
    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure, only the order of the elements in the resulting collection.
    @inlinable
    @inline(__always)
    func concurrentCompactMap<T>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping (Element) throws -> T?
    ) async throws -> [T] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(of: (Index, [T]).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try (
                        stableCurrentIndex,
                        self[safe: stableCurrentIndex..<nextIndex].compactMap(transform)
                    )
                }
                currentIndex = nextIndex
            }

            var initialResult = try await taskGroup.reduce(into: []) { $0.append($1) }
            initialResult.sort { $0.0 < $1.0 }

            return initialResult.reduce(into: []) { $0.append(contentsOf: $1.1) }
        }
    }

    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure.
    @inlinable
    @inline(__always)
    func concurrentFilter(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ isIncluded: @escaping (Element) throws -> Bool
    ) async throws -> [Self.Element] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(
            of: (Index, [Self.Element]).self
        ) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try (
                        stableCurrentIndex,
                        self[safe: stableCurrentIndex..<nextIndex].filter(isIncluded)
                    )
                }
                currentIndex = nextIndex
            }

            var initialResult = try await taskGroup.reduce(into: []) { $0.append($1) }
            initialResult.sort { $0.0 < $1.0 }

            return initialResult.reduce(into: []) { $0.append(contentsOf: $1.1) }
        }
    }

    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure.
    @inlinable
    @inline(__always)
    func concurrentAllSatisfy(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ predicate: @escaping (Element) throws -> Bool
    ) async throws -> Bool {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(of: Bool.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try self[safe: stableCurrentIndex..<nextIndex].allSatisfy(predicate)
                }
                currentIndex = nextIndex
            }

            return try await taskGroup.allSatisfy(==true)
        }
    }

    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure.
    @inlinable
    @inline(__always)
    func concurrentContains(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        where isSatisfied: @escaping (Element) throws -> Bool
    ) async throws -> Bool {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(of: Bool.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try self[safe: stableCurrentIndex..<nextIndex].contains(where: isSatisfied)
                }
                currentIndex = nextIndex
            }

            return try await taskGroup.contains(where: ==true)
        }
    }
}
