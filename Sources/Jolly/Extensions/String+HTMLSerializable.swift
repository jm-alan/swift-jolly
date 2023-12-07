extension String: HTMLSerializable {
    @inlinable
    public var innerText: String { self }

    @inlinable
    public var innerHTML: String { self }

    @inlinable
    public func serialize() -> String { self }
}
