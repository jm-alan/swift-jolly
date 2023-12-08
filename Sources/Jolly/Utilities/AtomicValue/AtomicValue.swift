public final class AtomicValue<Wrapped> {
    @usableFromInline
    let mutex: Mutex = .init()

    @usableFromInline
    var wrapped: Wrapped

    @inlinable
    @inline(__always)
    public func use<T>(in consumer: (Wrapped) throws -> T) rethrows -> T {
        try mutex.atomize(expression: consumer(wrapped))
    }

    @inlinable
    @inline(__always)
    public func mut(in consumer: (inout Wrapped) throws -> Void) rethrows {
        try mutex.atomize(expression: consumer(&wrapped))
    }

    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}

// AtomicValue can safely conform to unchecked Sendable as its only mutable
// property is not accessible directly, and can only be mutated via mutex-
// controlled member functions
extension AtomicValue: @unchecked Sendable {}
