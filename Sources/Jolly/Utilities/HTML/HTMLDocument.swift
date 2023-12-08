public class HTMLDocument {
    public var head: [HTMLElement]
    public var body: HTMLElement?

    @inlinable
    @inline(__always)
    public func serialize(pretty: Bool = false) throws -> String {
        var composed = try head.reduce("") { try $0 + $1.serialize(pretty: pretty) }

        try composed += body?.serialize(pretty: pretty, depth: 1) ?? ""

        return pretty
            ? """
            <!DOCTYPE html>
            <html>\
            \(composed)
            </html>
            """
            : "<!DOCTYPE html><html>\(composed)</html>"
    }

    public init(head: [HTMLElement] = .init(), body: HTMLElement? = nil) {
        self.head = head
        self.body = body
    }
}
