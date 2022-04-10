@testable import Jolly
import XCTest

final class ArrayExtensionTests: XCTestCase {
    func testSafeSubscript() {
        let someArray = [1, 2, 3, 4, 5]
        let badAccess = someArray[safe: 5]
        XCTAssertNil(badAccess)
    }

    struct KeypathTester: Equatable {
        let someProp: Int
        let otherProp: String
        let optProp: Bool?

        init(_ someProp: Int, _ otherProp: String, _ optProp: Bool? = nil) {
            self.someProp = someProp
            self.otherProp = otherProp
            self.optProp = optProp
        }
    }

    let tests: [KeypathTester] = [
        .init(1, "one", true),
        .init(1, "two"),
        .init(1, "three", false),
        .init(2, "four"),
        .init(2, "five", true),
        .init(2, "six"),
        .init(3, "seven", false),
        .init(3, "eight"),
        .init(3, "nine", true),
    ]

    func testKeyMap() {
        let expectedMap: [Int] = [1, 1, 1, 2, 2, 2, 3, 3, 3]
        let mapped: [Int] = tests.map(\.someProp)
        XCTAssertEqual(mapped, expectedMap)
    }

    func testComparatorFilter() {
        let expectedFilter: [KeypathTester] = [tests[3], tests[4], tests[5]]
        let filtered: [KeypathTester] = tests.filter(\.someProp == 2)
        XCTAssertEqual(filtered, expectedFilter)
    }

    func testNilter() {
        let expectedFilter: [KeypathTester] = [
            tests[0],
            tests[2],
            tests[4],
            tests[6],
            tests[8],
        ]
        let filtered: [KeypathTester] = tests.nilter(\.optProp)
        XCTAssertEqual(filtered, expectedFilter)
    }

    func testKeyCompactMap() {
        let expectedMap: [Bool] = [true, false, true, false, true]
        let mapped: [Bool] = tests.compactMap(\.optProp)
        XCTAssertEqual(mapped, expectedMap)
    }

    func testComparatorAllSatisfy() {
        XCTAssertTrue(tests.allSatisfy(\.otherProp.count >= 3))
        XCTAssertTrue(tests.allSatisfy(\.someProp <= 3))
        XCTAssertFalse(tests.allSatisfy(\.someProp == 0))
    }

    func testGrouped() {
        let firstExpected = [
            1: [tests[0], tests[1], tests[2]],
            2: [tests[3], tests[4], tests[5]],
            3: [tests[6], tests[7], tests[8]],
        ]
        let secondExpected: [Int: [String]] = [
            1: ["one", "two", "three"],
            2: ["four", "five", "six"],
            3: ["seven", "eight", "nine"],
        ]
        let thirdExpected: [Int: Int] = [1: 3, 2: 6, 3: 9]

        let firstMatching1 = tests.grouped { $0.someProp }
        let firstMatching2 = tests.grouped(by: \.someProp)

        let secondMatching1 = tests
            .grouped {
                $0.someProp
            } valueSelector: {
                $0.otherProp
            }
        let secondMatching2 = tests.grouped(by: \.someProp) { $0.otherProp }
        let secondMatching3 = tests.grouped(by: \.someProp, extracting: \.otherProp)
        let secondMatching4 = tests.grouped(by: \.someProp) { $0.map(\.otherProp) }

        let thirdMatching1 = tests.grouped(by: \.someProp, extracting: \.someProp) {
            $0.reduce(0, +)
        }
        let thirdMatching2 = tests.groupedReduce(0) { $0.someProp } reducer: { $0 + $1.someProp }

        XCTAssertEqual(firstExpected, firstMatching1)
        XCTAssertEqual(firstExpected, firstMatching2)
        XCTAssertEqual(secondExpected, secondMatching1)
        XCTAssertEqual(secondExpected, secondMatching2)
        XCTAssertEqual(secondExpected, secondMatching3)
        XCTAssertEqual(secondExpected, secondMatching4)
        XCTAssertEqual(thirdExpected, thirdMatching1)
        XCTAssertEqual(thirdExpected, thirdMatching2)
    }

    func testIndexed() {
        let firstExpected = [
            "one": tests[0],
            "two": tests[1],
            "three": tests[2],
            "four": tests[3],
            "five": tests[4],
            "six": tests[5],
            "seven": tests[6],
            "eight": tests[7],
            "nine": tests[8],
        ]

        let firstMatching = tests.indexed(by: \.otherProp)

        XCTAssertEqual(firstExpected, firstMatching)
    }
}
