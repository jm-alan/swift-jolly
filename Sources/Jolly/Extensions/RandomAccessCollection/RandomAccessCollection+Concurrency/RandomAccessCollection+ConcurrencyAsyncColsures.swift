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
        _ body: @escaping (Element) async -> Void
    ) async {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )

        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        await withTaskGroup(of: Void.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    await self[safe: stableCurrentIndex..<nextIndex].forEach(body)
                }
                currentIndex = nextIndex
            }

            await taskGroup.waitForAll()
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
        _ transform: @escaping (Element) async -> T
    ) async -> [T] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )

        var (divisionLength, rem) = count.quotientAndRemainder(dividingBy: divisions)
        divisionLength += Swift.min(rem, 1)

        return await withTaskGroup(of: (Index, [T]).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)

                taskGroup.addTask {
                    (
                        stableCurrentIndex,
                        await self[safe: stableCurrentIndex..<nextIndex].map(transform)
                    )
                }

                currentIndex = nextIndex
            }

            var initialResult = await taskGroup.reduce(into: []) { $0.append($1) }
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
        _ transform: @escaping (Element) async -> T?
    ) async -> [T] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return await withTaskGroup(of: (Index, [T]).self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    (
                        stableCurrentIndex,
                        await self[safe: stableCurrentIndex..<nextIndex].compactMap(transform)
                    )
                }
                currentIndex = nextIndex
            }

            var initialResult = await taskGroup.reduce(into: []) { $0.append($1) }
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
        _ isIncluded: @escaping (Element) async -> Bool
    ) async -> [Self.Element] {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return await withTaskGroup(
            of: (Index, [Self.Element]).self
        ) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    (
                        stableCurrentIndex,
                        await self[safe: stableCurrentIndex..<nextIndex].filter(isIncluded)
                    )
                }
                currentIndex = nextIndex
            }

            var initialResult = await taskGroup.reduce(into: []) { $0.append($1) }
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
        _ predicate: @escaping (Element) async -> Bool
    ) async -> Bool {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return await withTaskGroup(of: Bool.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    await self[safe: stableCurrentIndex..<nextIndex].allSatisfy(predicate)
                }
                currentIndex = nextIndex
            }

            return await taskGroup.allSatisfy(==true)
        }
    }

    /// Note that this function makes no guarantees about the concurrency safey of the provided
    /// closure.
    @inlinable
    @inline(__always)
    func concurrentContains(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        where isSatisfied: @escaping (Element) async -> Bool
    ) async -> Bool {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return await withTaskGroup(of: Bool.self) { taskGroup in
            var currentIndex: Index = startIndex

            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    await self[safe: stableCurrentIndex..<nextIndex].contains(where: isSatisfied)
                }
                currentIndex = nextIndex
            }

            return await taskGroup.contains(where: ==true)
        }
    }
}
