extension AtomicValue: SimpleInitializable where Wrapped: SimpleInitializable {
    @inlinable
    @inline(__always)
    public init() {
        wrapped = .init()
    }
}
