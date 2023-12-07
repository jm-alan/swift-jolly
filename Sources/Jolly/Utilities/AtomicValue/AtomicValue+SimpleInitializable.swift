extension AtomicValue: SimpleInitializable where Wrapped: SimpleInitializable {
    public init() {
        wrapped = .init()
    }
}
