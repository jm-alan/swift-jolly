@testable import Jolly
import XCTest

struct SimpleStruct: Equatable {
    let someString: String
    let someInt: Int
}

extension SimpleStruct: Comparable {
    @inlinable
    @inline(__always)
    static func < (
        _ lhs: Self,
        _ rhs: Self
    ) -> Bool { lhs.someString < rhs.someString && lhs.someInt < rhs.someInt }
}

final class ComparatorOperatorTests: XCTestCase {
    static var someArr: [SimpleStruct] = .init()
    static let arrCapacity: Int = 10000

    override func setUp() {
        Self.someArr.reserveCapacity(Self.arrCapacity)
        for _ in 0..<Self.arrCapacity {
            let randomInt: Int = .random(in: 0...Self.arrCapacity)
            Self.someArr.append(.init(someString: "\(randomInt)", someInt: randomInt))
        }
    }

    override func tearDown() {
        Self.someArr = .init()
    }

    func testKeyComparator() {}
}
