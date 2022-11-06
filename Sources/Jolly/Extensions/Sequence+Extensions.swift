import Foundation

public extension Sequence where Self: RandomAccessCollection, Self: RangeReplaceableCollection {
    @inlinable
    @inline(__always)
    subscript(safe range: Range<Index>) -> SubSequence {
        var constrainedLowerIndex: Index = startIndex
        var constrainedUpperIndex: Index = endIndex
        if
            range.lowerBound >= startIndex,
            range.lowerBound < endIndex
        { constrainedLowerIndex = range.lowerBound }
        if
            range.upperBound >= startIndex,
            range.upperBound < endIndex
        { constrainedUpperIndex = range.upperBound }
        return self[constrainedLowerIndex..<constrainedUpperIndex]
    }

    @inlinable
    @inline(__always)
    subscript(safe range: ClosedRange<Index>) -> SubSequence {
        return self[safe: range.lowerBound..<index(range.upperBound, offsetBy: 1)]
    }

    @inlinable
    @inline(__always)
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    // MARK: - Concurrency

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

        return try await withThrowingTaskGroup(of: R.self) { taskGroup in
            var currentIndex: Index = startIndex
            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try await self[safe: stableCurrentIndex..<nextIndex].map(transform)
                }
                currentIndex = nextIndex
            }
            return try await taskGroup.reduce(into: .init()) { $0.append(contentsOf: $1) }
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

        return try await withThrowingTaskGroup(of: R.self) { taskGroup in
            var currentIndex: Index = startIndex
            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try await self[safe: stableCurrentIndex..<nextIndex].compactMap(transform)
                }
                currentIndex = nextIndex
            }
            return try await taskGroup.reduce(into: .init()) { $0.append(contentsOf: $1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentFilter(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ isIncluded: @escaping (Element) async throws -> Bool
    ) async throws -> Self {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(
            of: SubSequence.self
        ) { taskGroup in
            var currentIndex: Index = startIndex
            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try await self[safe: stableCurrentIndex..<nextIndex].filter(isIncluded)
                }
                currentIndex = nextIndex
            }
            return try await taskGroup.reduce(into: .init()) { $0.append(contentsOf: $1) }
        }
    }

    @inlinable
    @inline(__always)
    func concurrentNilter<T>(
        in maxConcurrentDivisions: Int = ProcessInfo.processInfo.activeProcessorCount,
        _ isNil: @escaping (Element) async throws -> T?
    ) async throws -> Self {
        let divisions: Int = Swift.min(
            maxConcurrentDivisions,
            ProcessInfo.processInfo.activeProcessorCount
        )
        let divisionLength: Int = .init((Double(count) / Double(divisions)).rounded(.up))

        return try await withThrowingTaskGroup(
            of: SubSequence.self
        ) { taskGroup in
            var currentIndex: Index = startIndex
            while currentIndex < endIndex {
                let stableCurrentIndex: Index = currentIndex
                let nextIndex: Index = index(stableCurrentIndex, offsetBy: divisionLength)
                taskGroup.addTask {
                    try await self[safe: stableCurrentIndex..<nextIndex].nilter(isNil)
                }
                currentIndex = nextIndex
            }
            return try await taskGroup.reduce(into: .init()) { $0.append(contentsOf: $1) }
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

    // MARK: - Overloads of existing functions using keypaths for simplicity

    @inlinable
    @inline(__always)
    func map<T>(
        _ keyPath: KeyPath<Element, T>
    ) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func filter<C>(
        _ comparator: KeyValComparator<Element, C>
    ) -> Self where C: Comparable {
        filter(comparator.getValue)
    }

    @inlinable
    @inline(__always)
    func filter(
        _ keyPath: KeyPath<Element, Bool>
    ) -> Self {
        filter { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func nilter<O>(
        _ nilter: (Element) -> O?
    ) -> Self {
        filter { nilter($0) != nil }
    }

    @inlinable
    @inline(__always)
    func nilter<O>(
        _ nilter: (Element) throws -> O?
    ) rethrows -> Self {
        try filter { try nilter($0) != nil }
    }

    @inlinable
    @inline(__always)
    func nilter<T>(
        _ keyPath: KeyPath<Element, T?>
    ) -> Self {
        filter { $0[keyPath: keyPath] != nil }
    }

    @inlinable
    @inline(__always)
    func compactMap<T>(
        _ keyPath: KeyPath<Element, T?>
    ) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func allSatisfy<C>(
        _ predicate: KeyValComparator<Element, C>
    ) -> Bool {
        allSatisfy(predicate.getValue(comparing:))
    }

    @inlinable
    @inline(__always)
    func contains<E>(
        _ element: Element,
        criteria keyPath: KeyPath<Element, E>
    ) -> Bool where E: Equatable {
        contains { $0[keyPath: keyPath] == element[keyPath: keyPath] }
    }

    // MARK: - Async overloads of existing methods

    @inlinable
    @inline(__always)
    func forEach(
        _ body: (Element) async throws -> Void
    ) async rethrows {
        for el: Element in self {
            try await body(el)
        }
    }

    @inlinable
    @inline(__always)
    func map<R>(
        _ transform: (Element) async throws -> R.Element
    ) async rethrows -> R where R: RangeReplaceableCollection {
        var mapped: R = .init()
        for el: Element in self {
            try await mapped.append(transform(el))
        }
        return mapped
    }

    @inlinable
    @inline(__always)
    func compactMap<R>(
        _ transform: (Element) async throws -> R.Element?
    ) async rethrows -> R where R: RangeReplaceableCollection {
        var mapped: R = .init()
        for el: Element in self {
            guard let transformed: R.Element = try await transform(el) else { continue }
            mapped.append(transformed)
        }
        return mapped
    }

    @inlinable
    @inline(__always)
    func filter(
        _ isIncluded: (Element) async throws -> Bool
    ) async rethrows -> Self {
        var filtered: Self = .init()
        for el: Element in self {
            if try await isIncluded(el) { filtered.append(el) }
        }
        return filtered
    }

    @inlinable
    @inline(__always)
    func reduce<T>(
        _ initialValue: T,
        _ reducer: (T, Element) async throws -> T
    ) async rethrows -> T {
        var result: T = initialValue
        for el: Element in self {
            result = try await reducer(result, el)
        }
        return result
    }

    @inlinable
    @inline(__always)
    func reduce<T>(
        into initialValue: T,
        _ mutatingReducer: (inout T, Element) async throws -> Void
    ) async rethrows -> T {
        var result: T = initialValue
        for el: Element in self {
            try await mutatingReducer(&result, el)
        }
        return result
    }

    @inlinable
    @inline(__always)
    func contains(
        where isSatisfied: (Element) async throws -> Bool
    ) async rethrows -> Bool {
        for el: Element in self {
            if try await isSatisfied(el) { return true }
        }
        return false
    }

    @inlinable
    @inline(__always)
    func allSatisfy(
        _ predicate: (Element) async throws -> Bool
    ) async rethrows -> Bool {
        for el: Element in self {
            guard try await predicate(el) else { return false }
        }
        return true
    }

    @inlinable
    @inline(__always)
    func nilter<T>(
        _ nilter: (Element) async throws -> T?
    ) async rethrows -> Self {
        var niltered = Self()
        for el: Element in self {
            guard try await nilter(el) != nil else { continue }
            niltered.append(el)
        }
        return niltered
    }

    // MARK: - New methods, array -> dictionary

    @inlinable
    @inline(__always)
    func grouped<H>(
        by keySelector: (Element) -> H
    ) -> [H: [Element]] where H: Hashable {
        .init(grouping: self, by: keySelector)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) -> KeyType,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: [ValueType]] where KeyType: Hashable {
        grouped(by: keySelector) { $0.map(valueSelector) }
    }

    @inlinable
    @inline(__always)
    func grouped<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: [Element]] where H: Hashable {
        grouped { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, ValueType>
    ) -> [KeyType: [ValueType]] where KeyType: Hashable {
        grouped {
            $0[keyPath: keyPath]
        } valueSelector: {
            $0[keyPath: valuePath]
        }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) -> KeyType,
        sink: ([Element]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func groupedFilter<H>(
        by keySelector: (Element) -> H,
        filter: (Element) -> Bool
    ) -> [H: [Element]] where H: Hashable {
        grouped(by: keySelector) { $0.filter(filter) }
    }

    @inlinable
    @inline(__always)
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) -> KeyType,
        nilter: (Element) -> OptionalType?
    ) -> [KeyType: [Element]] where KeyType: Hashable {
        grouped(by: keySelector) { $0.nilter(nilter) }
    }

    @inlinable
    @inline(__always)
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) -> KeyType,
        reducer: (ResultType, Element) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keySelector) { $0.reduce(initialValue, reducer) }
    }

    // MARK: - Grouping methods but throwing

    @inlinable
    @inline(__always)
    func grouped<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: [Element]] where H: Hashable {
        try .init(grouping: self, by: keySelector)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: [ValueType]] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.map(valueSelector) }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) throws -> KeyType,
        sink: ([Element]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func groupedFilter<H>(
        by keySelector: (Element) throws -> H,
        filter: (Element) throws -> Bool
    ) rethrows -> [H: [Element]] where H: Hashable {
        try grouped(by: keySelector) { try $0.filter(filter) }
    }

    @inlinable
    @inline(__always)
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) throws -> KeyType,
        nilter: (Element) throws -> OptionalType?
    ) rethrows -> [KeyType: [Element]] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.nilter(nilter) }
    }

    @inlinable
    @inline(__always)
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) throws -> KeyType,
        reducer: (ResultType, Element) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.reduce(initialValue, reducer) }
    }

    // MARK: - New methods, array -> indexed dictionary

    @inlinable
    @inline(__always)
    func indexed<H>(
        by keySelector: (Element) -> H
    ) -> [H: Element] where H: Hashable {
        reduce(into: [:]) { $0[keySelector($1)] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) -> KeyType,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        reduce(into: [:]) { $0[keySelector($1)] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: Element] where H: Hashable {
        reduce(into: [:]) { $0[$1[keyPath: keyPath]] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        reduce(into: [:]) { $0[$1[keyPath: keyPath]] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, ValueType>
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        reduce(into: [:]) { $0[$1[keyPath: keyPath]] = $1[keyPath: valuePath] }
    }

    // MARK: - Indexed methods but throwing

    @inlinable
    @inline(__always)
    func indexed<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: Element] where H: Hashable {
        try reduce(into: [:]) { try $0[keySelector($1)] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try reduce(into: [:]) { try $0[keySelector($1)] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try reduce(into: [:]) { try $0[$1[keyPath: keyPath]] = valueSelector($1) }
    }

    // MARK: - Grouping methods but async

    @inlinable
    @inline(__always)
    func grouped<H>(
        by keySelector: (Element) async throws -> H
    ) async rethrows -> [H: [Element]] where H: Hashable {
        try await .init(grouping: self, by: keySelector)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) async throws -> KeyType,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: [ValueType]] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.map(valueSelector) }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) async throws -> KeyType,
        sink: ([Element]) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func groupedFilter<H>(
        by keySelector: (Element) async throws -> H,
        filter: (Element) async throws -> Bool
    ) async rethrows -> [H: [Element]] where H: Hashable {
        try await grouped(by: keySelector) { try await $0.filter(filter) }
    }

    @inlinable
    @inline(__always)
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) async throws -> KeyType,
        nilter: (Element) async throws -> OptionalType?
    ) async rethrows -> [KeyType: [Element]] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.nilter(nilter) }
    }

    @inlinable
    @inline(__always)
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) async throws -> KeyType,
        reducer: (ResultType, Element) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.reduce(initialValue, reducer) }
    }

    // MARK: - Indexed methods but async

    @inlinable
    @inline(__always)
    func indexed<H>(
        by keySelector: (Element) async throws -> H
    ) async rethrows -> [H: Element] where H: Hashable {
        try await reduce(into: [:]) { try await $0[keySelector($1)] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) async throws -> KeyType,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await reduce(into: [:]) { try await $0[keySelector($1)] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await reduce(into: [:]) { try await $0[$1[keyPath: keyPath]] = valueSelector($1) }
    }
}
