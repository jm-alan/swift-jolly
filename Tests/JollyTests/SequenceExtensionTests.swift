import Jest
@testable import Jolly
import XCTest

final class SequenceExtensionTests: XCTestCase {
    static var someArr: [Int] = .init()

    static let arrCapacity = 1_000_000

    override class func setUp() {
        someArr.reserveCapacity(arrCapacity)
        for _ in 0..<arrCapacity {
            someArr.append(Int.random(in: 1...(arrCapacity >< 1_000_000)))
        }
    }

    override class func tearDown() {
        someArr = .init()
    }

    func testSafeAccess() {
        let smallArr = [0, 1, 2, 3]
        let safeSlice = smallArr[0...3]

        XCTAssertNotNil(smallArr[3])
        XCTAssertNil(smallArr[safe: 4])
        XCTAssertEqual(smallArr[safe: -1000...1000], safeSlice)
        XCTAssertEqual(smallArr[safe: -1000...3], safeSlice)
        XCTAssertEqual(smallArr[safe: 0...1000], safeSlice)
    }

    struct SimpleStruct {
        let someVal: Int
    }

    func testConcurrentForEach() async {
        var counter: AtomicValue<Int> = .init()
        let expectedCounter: Int = Self.someArr.reduce(0, +)

        await Self.someArr.concurrentForEach { counter += $0 }

        counter.use { (val: Int) in
            XCTAssertEqual(expectedCounter, val)
        }
    }

    func testConcurrentMap() async {
        let expectedMapResult: [Int] = Self.someArr.map { $0 * 2 }
        var computedMapResult: [Int] = .init()

        await computedMapResult = Self.someArr.concurrentMap { $0 * 2 }

        for i in 0..<Self.arrCapacity {
            if expectedMapResult[i] != computedMapResult[i] {
                XCTFail(
                    "Failed at index \(i); expected: \(expectedMapResult[i]) but found \(computedMapResult[i])"
                )
                return
            }
        }
    }

    func testConcurrency() async {
        var expectedOddsOnly: [Int] = .init()
        var computedOddsOnly: [Int] = .init()

        var expectedDoubledEvens: [Int] = .init()
        var computedDoubledEvens: [Int] = .init()

        var simpleStructsDoSatisfy: [SimpleStruct] = .init()
        var simpleStructsDoNotSatisfy: [SimpleStruct] = .init()

        for i in 0..<Self.arrCapacity {
            if Self.someArr[i] % 2 == 0 { expectedDoubledEvens.append(Self.someArr[i] * 2) }
            if Self.someArr[i] % 2 != 0 { expectedOddsOnly.append(Self.someArr[i]) }
            simpleStructsDoSatisfy.append(.init(someVal: 1_000_000 + Self.someArr[i]))
            simpleStructsDoNotSatisfy.append(.init(someVal: 1_000_000 - Self.someArr[i]))
        }

        await computedOddsOnly = Self.someArr.concurrentFilter { $0 % 2 != 0 }
        await computedDoubledEvens = Self
            .someArr
            .concurrentCompactMap { $0 % 2 == 0 ? $0 * 2 : nil }

        await AsyncAssert(await simpleStructsDoSatisfy.concurrentAllSatisfy { $0.someVal >= 1000 })
        await AsyncAssert(
            await simpleStructsDoSatisfy
                .concurrentContains { $0.someVal >= 1_000_000 }
        )
        await AsyncAssertFalse(
            await simpleStructsDoNotSatisfy
                .concurrentAllSatisfy { $0.someVal >= 1_000_000 }
        )

        XCTAssertEqual(expectedOddsOnly, computedOddsOnly)
        XCTAssertEqual(expectedDoubledEvens, computedDoubledEvens)
    }
}
