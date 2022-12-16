// @testable import Jolly
// import Jest
// import XCTest

// final class SequenceExtensionTests: XCTestCase {
//     static var someArr: [Int] = .init()

//     override class func setUp() {
//         someArr.reserveCapacity(10000000)
//         for i in 0..<10000000 {
//             someArr.append(i)
//         }
//     }

//     override class func tearDown() {
//         someArr = .init()
//     }

//     func testSafeAccess() {
//         let smallArr = [0, 1, 2, 3]
//         let safeSlice = smallArr[0...3]

//         XCTAssertNotNil(smallArr[3])
//         XCTAssertNil(smallArr[safe: 4])
//         XCTAssertEqual(smallArr[safe: -1000...1000], safeSlice)
//         XCTAssertEqual(smallArr[safe: -1000...3], safeSlice)
//         XCTAssertEqual(smallArr[safe: 0...1000], safeSlice)
//     }

//     struct SimpleStruct {
//         let someVal: Int
//     }

//     func testConcurrentForEach() async {
//         var counter: AtomicValue<Int> = .init()
//         let expectedCounter: Int = (9999999 * 10000000) / 2

//         await AsyncAssertNoThrow(
//             try await Self.someArr.concurrentForEach { counter += $0 }
//         )
//         XCTAssert(expectedCounter == counter)
//     }

//     func testConcurrentMap() async {
//         let expectedMapResult: [Int] = Self.someArr.map { $0 * 2 }
//         var computedMapResult: [Int] = .init()

//         await AsyncAssertNoThrow(
//             try await computedMapResult = Self.someArr.concurrentMap { $0 * 2 }
//         )
//         for i in 0..<10000000 {
//             if expectedMapResult[i] != computedMapResult[i] {
//                 XCTFail("Failed at index \(i); expected: \(expectedMapResult[i]) but found \(computedMapResult[i])")
//                 return
//             }
//         }
//     }

//     func testConcurrency() async throws {
//         var expectedEvensOnly: [Int] = .init()
//         var computedEvensOnly: [Int] = .init()

//         var expectedOddsOnly: [Int] = .init()
//         var computedOddsOnly: [Int] = .init()

//         var expectedDoubledEvens: [Int] = .init()
//         var computedDoubledEvens: [Int] = .init()

//         var simpleStructsDoSatisfy: [SimpleStruct] = .init()
//         var simpleStructsDoNotSatisfy: [SimpleStruct] = .init()

//         for i in 0..<1000000 {
//             if i % 2 == 0 { expectedEvensOnly.append(i) }
//             if i % 2 == 0 { expectedDoubledEvens.append(i * 2) }
//             if i % 2 != 0 { expectedOddsOnly.append(i) }
//             simpleStructsDoSatisfy.append(.init(someVal: 1000 + i))
//             simpleStructsDoNotSatisfy.append(.init(someVal: 1000000 - i))
//         }
//         await AsyncAssertNoThrow(
//             try await computedEvensOnly = Self.someArr.concurrentNilter { $0 % 2 == 0 ? $0 : nil }
//         )
//         await AsyncAssertNoThrow(
//             try await computedOddsOnly = Self.someArr.concurrentFilter { $0 % 2 != 0 }
//         )
//         await AsyncAssertNoThrow(
//             try await computedDoubledEvens = Self.someArr.concurrentCompactMap {
//                 $0 % 2 == 0 ? $0 * 2 : nil
//             }
//         )
//         try await AsyncAssertTrue(
//             try await simpleStructsDoSatisfy.concurrentAllSatisfy { $0.someVal >= 1000 }
//         )
//         try await AsyncAssertFalse(
//             try await simpleStructsDoNotSatisfy.concurrentAllSatisfy { $0.someVal >= 1000 }
//         )
//         try await AsyncAssertTrue(
//             try await simpleStructsDoSatisfy.concurrentContains { $0.someVal >= 1000000 }
//         )
//         XCTAssertEqual(expectedEvensOnly, computedEvensOnly)
//         XCTAssertEqual(expectedOddsOnly, computedOddsOnly)
//         XCTAssertEqual(expectedDoubledEvens, computedDoubledEvens)
//     }
// }
