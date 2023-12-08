extension AtomicValue: SimpleInitializable where Wrapped: SimpleInitializable {
    public convenience init() {
        self.init(wrapped: .init())
    }
}
