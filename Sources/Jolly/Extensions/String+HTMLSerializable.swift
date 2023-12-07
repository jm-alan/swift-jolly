import Foundation

extension String: HTMLSerializable {
    @inlinable
    public var innerText: String { self }

    @inlinable
    public func innerHTML(pretty _: Bool) -> String { self }

    @inlinable
    public func serialize(pretty _: Bool) -> String { self }
}
