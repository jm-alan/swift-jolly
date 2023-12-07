public struct HTMLSerializationError: Error {
    let tag: HTMLTag
    let children: [HTMLElement]
    let message: String

    public init(_ reason: Reason, tag: HTMLTag, children: [HTMLElement]) {
        self.tag = tag
        self.children = children
        message = reason.toString()
    }

    public enum Reason {
        case voidChildren

        @inlinable
        @inline(__always)
        public func toString() -> String {
            switch self {
            case .voidChildren:
                return "Void tag must not have children"
            }
        }
    }
}
