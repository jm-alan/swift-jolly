public class HTMLElement: HTMLSerializable {
    public let tag: HTMLTag
    public var children: [HTMLSerializable]
    public var attributes: [String: Attribute]

    public init(
        _ tag: HTMLTag,
        children: [HTMLSerializable] = .init(),
        attributes: [String: Attribute] = .init()
    ) {
        self.tag = tag
        self.children = children
        self.attributes = attributes
    }

    @inlinable
    public var innerText: String {
        tag.isVoid ? "" : children.reduce("") { $0 + $1.innerText }
    }

    @inlinable
    public func innerHTML(pretty: Bool = false, depth: Int = 0) throws -> String {
        try tag.isVoid
            ? ""
            : children.reduce("") { try $0 + $1.serialize(pretty: pretty, depth: depth) }
    }

    @inlinable
    public func serialize(pretty: Bool = false, depth: Int = 0) throws -> String {
        guard !tag.isVoid || children.isEmpty else {
            throw HTMLSerializationError(.voidChildren, tag: tag, children: children)
        }

        let delimeters = tag.delimeters()

        var openingTag = delimeters.0
        let closingTag = delimeters.1

        applyAttributes(to: &openingTag, pretty: pretty, depth: depth)

        return try pretty
            ? """

            \(expandIndentation(depth: depth, spacing: 4))\(openingTag)\
            \(innerHTML(pretty: true, depth: depth + 1))
            \(expandIndentation(depth: depth, spacing: 4))\(closingTag)
            """
            : "\(openingTag)\(innerHTML())\(closingTag)"
    }

    @inlinable
    func applyAttributes(to openingTag: inout String, pretty: Bool, depth: Int) {
        // semantics of this system guarantee that openingTag is never empty
        let closingBracket = openingTag.popLast()!

        let formattedBracket = pretty && !attributes.isEmpty
            ? """

            \(expandIndentation(depth: depth, spacing: 4))\
            \(closingBracket)
            """
            : String(closingBracket)

        for (attribute, wrappedValue) in attributes.sorted(by: { $0.key < $1.key }) {
            let formattedPrefix = pretty
                ? "\n\(expandIndentation(depth: depth + 1, spacing: 4))"
                : " "

            switch wrappedValue {
            case let .bool(shouldApply):
                if shouldApply {
                    openingTag += "\(formattedPrefix)\(attribute)"
                }
            case let .string(unwrappedValue):
                let attributeAssignment = "\(attribute)=\"\(unwrappedValue)\""
                openingTag += "\(formattedPrefix)\(attributeAssignment)"
            }
        }

        openingTag += formattedBracket
    }

    public enum Attribute {
        case bool(Bool)
        case string(String)
    }
}

public protocol HTMLSerializable {
    var innerText: String { get }
    func innerHTML(pretty: Bool, depth: Int) throws -> String
    func serialize(pretty: Bool, depth: Int) throws -> String
}
