@usableFromInline
struct PropertyAssertionBuilder<Mockable, Value> {
    @usableFromInline
    let accessor: KeyPath<Mockable, Value>
    @usableFromInline
    let value: Value
    @usableFromInline
    let accessRecord: [PartialKeyPath<Mockable>: [Any]]
    @usableFromInline
    let writeRecord: [PartialKeyPath<Mockable>: [Any]]
    @usableFromInline
    let invocationRecord: [PartialKeyPath<Mockable>: [Any]]
}

@usableFromInline
struct InvocableAssertionBuilder<Value> {
    @usableFromInline
    let memberFnName: String
    @usableFromInline
    let memberFn: Value
    @usableFromInline
    let invocationRecord: [String: [Any]]
}
