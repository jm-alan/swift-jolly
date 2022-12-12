public extension Dictionary {
    @inlinable
    @inline(__always)
    subscript(unsafe key: Key) -> Value {
        get {
            return self[key]!
        }
        set (val) {
            self[key] = val
        }
    }

    @inlinable
    @inline(__always)
    init<S>(
        grouping values: S,
        by keySelector: (S.Element) async throws -> Key
    ) async rethrows where S: Sequence, Value == [S.Element] {
        self.init()
        for val in values {
            if var current = try await self[keySelector(val)] {
                current.append(val)
            } else {
                try await self[keySelector(val)] = [val]
            }
        }
    }

    @inlinable
    @inline(__always)
    func mapValues<T>(
        _ transform: (Value) async throws -> T
    ) async rethrows -> [Key: T] {
        var mapped = [Key: T]()
        for keyVal in self {
            mapped[keyVal.key] = try await transform(keyVal.value)
        }
        return mapped
    }
}
