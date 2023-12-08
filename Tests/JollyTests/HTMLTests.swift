@testable import Jolly
import XCTest

final class HTMLTests: XCTestCase {
    func testBasicDocumentComposition() throws {
        let document: HTMLDocument = .init()

        try XCTAssertEqual("<!DOCTYPE html><html></html>", document.serialize())
    }

    func testBasicElementComposition() throws {
        let element: HTMLElement = .init(.div)

        try XCTAssertEqual("<div></div>", element.serialize())
    }

    func testVoidElementComposition() throws {
        let element: HTMLElement = .init(.img)

        try XCTAssertEqual("<img>", element.serialize())
    }

    func testAttributes() throws {
        let element: HTMLElement = .init(.div)

        element.attributes["onclick"] = .string("alert('Hi mom!')")

        try XCTAssertEqual("<div onclick=\"alert('Hi mom!')\"></div>", element.serialize())
    }

    func testHierarchicalComposition() throws {
        let document: HTMLDocument = .init()
        document.body = .init(.body)
        document.body!.children.append(HTMLElement(.div))
        try XCTAssertEqual(
            "<!DOCTYPE html><html><body><div></div></body></html>",
            document.serialize()
        )
    }

    func testPrettyPrint() throws {
        let document: HTMLDocument = .init()
        document.body = .init(.body)
        document.body!.children.append(HTMLElement(.div))

        try XCTAssertEqual(
            """
            <!DOCTYPE html>
            <html>
                <body>
                    <div>
                    </div>
                </body>
            </html>
            """,
            document.serialize(pretty: true)
        )
    }

    func testStringChildren() throws {
        let innermostDiv: HTMLElement = .init(.div)
        innermostDiv.children.append("This is plain text")

        let body: HTMLElement = .init(.body)
        body.children.append(innermostDiv)
        body.children.append("This is also plain text")

        let document: HTMLDocument = .init()
        document.body = body

        try XCTAssertEqual(
            """
            <!DOCTYPE html>
            <html>
                <body>
                    <div>
                        This is plain text
                    </div>
                    This is also plain text
                </body>
            </html>
            """,
            document.serialize(pretty: true)
        )
    }

    func testEverything() throws {
        let button: HTMLElement = .init(.button)
        button.children.append("Click me!")
        button.attributes["onclick"] = .string("alert('You did it!')")

        let div: HTMLElement = .init(.div)
        div.children.append("This is plain text")
        div.children.append(button)
        div.attributes["class"] = .string("w-full h-full flex flex-col")
        div.attributes["id"] = .string("root")

        let iframe: HTMLElement = .init(.iframe)
        iframe.attributes["src"] = .string("/live-reload.html")
        iframe.attributes["style"] = .string("display: none;")

        let body: HTMLElement = .init(.body)
        body.children.append(div)
        body.children.append("This is also plain text")
        body.children.append(iframe)
        body
            .attributes["class"] =
            .string(
                "w-[100svw] h-[100svh] overflow-hidden flex flex-col items-center justify-center"
            )

        body.attributes["id"] = .string("super-root")

        let document: HTMLDocument = .init(body: body)

        try XCTAssertEqual(
            """
            <!DOCTYPE html>
            <html>
                <body
                    class="w-[100svw] h-[100svh] overflow-hidden flex flex-col items-center justify-center"
                    id="super-root"
                >
                    <div
                        class="w-full h-full flex flex-col"
                        id="root"
                    >
                        This is plain text
                        <button
                            onclick="alert('You did it!')"
                        >
                            Click me!
                        </button>
                    </div>
                    This is also plain text
                    <iframe
                        src="/live-reload.html"
                        style="display: none;"
                    >
                    </iframe>
                </body>
            </html>
            """,
            document.serialize(pretty: true)
        )
    }
}
