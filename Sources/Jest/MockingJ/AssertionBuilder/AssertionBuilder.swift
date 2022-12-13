@usableFromInline
struct AssertionBuilder<Mocked, Value> {
    @usableFromInline
    let mocked: Mocked
    @usableFromInline
    let targetKeyPath: KeyPath<Mocked, Value>
    @usableFromInline
    let accessRecord: [PartialKeyPath<Mocked>: [Any]]
    @usableFromInline
    let writeRecord: [PartialKeyPath<Mocked>: [Any]]
    @usableFromInline
    let invocationRecord: [PartialKeyPath<Mocked>: [Any]]

    public init(
        _ mocked: Mocked,
        _ targetKeyPath: KeyPath<Mocked, Value>,
        _ accessRecord: [PartialKeyPath<Mocked>: [Any]],
        _ writeRecord: [PartialKeyPath<Mocked>: [Any]],
        _ invocationRecord: [PartialKeyPath<Mocked>: [Any]]
    ) {
        self.mocked = mocked
        self.targetKeyPath = targetKeyPath
        self.accessRecord = accessRecord
        self.writeRecord = writeRecord
        self.invocationRecord = invocationRecord
    }
}
