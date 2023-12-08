import Foundation

public extension RandomAccessCollection {
    @inlinable
    @inline(__always)
    func concurrentForEach(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ body: @escaping (Element) async throws -> Void
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
                    try await self[safe: stableCurrentIndex..<nextIndex].forEach(body)
                }
                currentIndex = nextIndex
            }
            try await taskGroup.waitForAll()
        }
    }

    @inlinable
    @inline(__always)
    func concurrentMap<R>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping (Element) async throws -> R.Element
    ) async throws -> R where R: RangeReplaceableCollection {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(of: (Index, R).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)

                taskGroup.addTask {
                    try (
                        stableCurrentIndex,
                        await self[safe: stableCurrentIndex..<nextIndex]
                            .map(transform)
                    )
                }

                currentIndex = nextIndex
            }

            return try await taskGroup
                .reduce(into: []) { $0.append($1) }
                .sorted { $0.0 < $1.0 }
                .reduce(into: .init()) { $0.append(contentsOf: $1.1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentCompactMap<R>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ transform: @escaping (Element) async throws -> R.Element?
    ) async throws -> R where R: RangeReplaceableCollection {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(of: (Index, R).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try (
                        stableCurrentIndex,
                        await self[safe: stableCurrentIndex..<nextIndex].compactMap(transform)
                    )
                }
                currentIndex = nextIndex
            }

            return try await taskGroup
                .reduce(into: []) { $0.append($1) }
                .sorted { $0.0 < $1.0 }
                .reduce(into: .init()) { $0.append(contentsOf: $1.1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentFilter(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ isIncluded: @escaping (Element) async throws -> Bool
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
                        await self[safe: stableCurrentIndex..<nextIndex].filter(isIncluded)
                    )
                }
                currentIndex = nextIndex
            }

            return try await taskGroup
                .reduce(into: []) { $0.append($1) }
                .sorted { $0.0 < $1.0 }
                .reduce(into: .init()) { $0.append(contentsOf: $1.1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentNilter<T>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ isNil: @escaping (Element) async throws -> T?
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
                        await self[safe: stableCurrentIndex..<nextIndex].nilter(isNil)
                    )
                }
                currentIndex = nextIndex
            }

            return try await taskGroup
                .reduce(into: []) { $0.append($1) }
                .sorted { $0.0 < $1.0 }
                .reduce(into: .init()) { $0.append(contentsOf: $1.1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentAllSatisfy(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ predicate: @escaping (Element) async throws -> Bool
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
                    try await self[safe: stableCurrentIndex..<nextIndex].allSatisfy(predicate)
                }
                currentIndex = nextIndex
            }

            return try await taskGroup.allSatisfy(==true)
        }
    }

    @inlinable
    @inline(__always)
    func concurrentContains(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        where isSatisfied: @escaping (Element) async throws -> Bool
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
                    try await self[
                        safe: stableCurrentIndex..<nextIndex
                    ].contains(where: isSatisfied)
                }
                currentIndex = nextIndex
            }

            return try await taskGroup.contains(where: ==true)
        }
    }
}
