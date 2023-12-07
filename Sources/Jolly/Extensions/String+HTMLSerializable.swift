import Foundation

extension String: HTMLSerializable {
    @inlinable
    public var innerText: String { self }

    @inlinable
    public func innerHTML(pretty: Bool, depth: Int) -> String {
        let indentPrefix = expandIndentation(depth: depth, spacing: 4)

        return pretty
            ? """

            \(indentPrefix)\(replacingOccurrences(
                of: "\n",
                with: "\(indentPrefix)\n"
            ))
            """
            : self
    }

    @inlinable
    public func serialize(pretty: Bool, depth: Int) -> String {
        innerHTML(pretty: pretty, depth: depth)
    }
}
