public struct AtomicValue<Wrapped> {
    @usableFromInline
    let mutex: Mutex = .init()

    @usableFromInline
    var wrapped: Wrapped

    @inlinable
    @inline(__always)
    public func use(in consumer: (Wrapped) throws -> Void) rethrows {
        try mutex.atomize(expression: consumer(wrapped))
    }

    @inlinable
    @inline(__always)
    public mutating func use(in consumer: (inout Wrapped) throws -> Void) rethrows {
        try mutex.atomize(expression: consumer(&wrapped))
    }

    @inlinable
    @inline(__always)
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}
