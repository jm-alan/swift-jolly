import XCTest

final class BuggyFailureDisplay: XCTestCase {
    func testBuggyAssertionFailure() {
        XCTFail("""
            You would expect this entire error to display,
            however, every line from this one onward will
            be cut off in the inline failure view, despite
            appearing correctly in XCode and command
            line output
            """)
    }
}
