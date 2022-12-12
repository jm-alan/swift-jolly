@testable import Jest
import Jolly
import XCTest

final class MockingJProvingGrounds: XCTestCase {
    struct SimpleStruct {
        let someImmutableProp: Int
        var someMutableProp: String

        let returnOne: (Int)
            -> Int = { $0 }
        let addTwo: (Int, Int)
            -> Int = { $0 + $1 }
        let addThree: (Int, Int, Int)
            -> Int = { $0 + $1 + $2 }
        let addFour: (Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 }
        let addFive: (Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 }
        let addSix: (Int, Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 + $5 }
        let addSeven: (Int, Int, Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 + $5 + $6 }
        let addEight: (Int, Int, Int, Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 }
        let addNine: (Int, Int, Int, Int, Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 }
        let addTen: (Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)
            -> Int = { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 }
        func addToImmutableProp(_ value: Int) -> Int { value + someImmutableProp }

        var someComputedProp: Int { get throws { 7 } }
    }

    func testMockableObject() {
        let mockedStruct: Mocked<SimpleStruct> = .init(
            mocking: .init(
                someImmutableProp: 7,
                someMutableProp: "this is a string"
            )
        )

        var expectedParamsOne: [Int] = .init()
        var expectedParamsTwo: [(Int, Int)] = .init()
        var expectedParamsThree: [(Int, Int, Int)] = .init()
        var expectedParamsFour: [(Int, Int, Int, Int)] = .init()
        var expectedParamsFive: [(Int, Int, Int, Int, Int)] = .init()
        var expectedParamsSix: [(Int, Int, Int, Int, Int, Int)] = .init()
        var expectedParamsSeven: [(Int, Int, Int, Int, Int, Int, Int)] = .init()
        var expectedParamsEight: [(Int, Int, Int, Int, Int, Int, Int, Int)] = .init()
        var expectedParamsNine: [(Int, Int, Int, Int, Int, Int, Int, Int, Int)] = .init()
        var expectedParamsTen: [(Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)] = .init()

        var expectedReturnsOne: [Int] = .init()
        var expectedReturnsTwo: [Int] = .init()
        var expectedReturnsThree: [Int] = .init()
        var expectedReturnsFour: [Int] = .init()
        var expectedReturnsFive: [Int] = .init()
        var expectedReturnsSix: [Int] = .init()
        var expectedReturnsSeven: [Int] = .init()
        var expectedReturnsEight: [Int] = .init()
        var expectedReturnsNine: [Int] = .init()
        var expectedReturnsTen: [Int] = .init()

        for i in 0..<1000 {
            mockedStruct[\.returnOne](i)
            mockedStruct[\.addTwo](i, i)
            mockedStruct[\.addThree](i, i, i)
            mockedStruct[\.addFour](i, i, i, i)
            mockedStruct[\.addFive](i, i, i, i, i)
            mockedStruct[\.addSix](i, i, i, i, i, i)
            mockedStruct[\.addSeven](i, i, i, i, i, i, i)
            mockedStruct[\.addEight](i, i, i, i, i, i, i, i)
            mockedStruct[\.addNine](i, i, i, i, i, i, i, i, i)
            mockedStruct[\.addTen](i, i, i, i, i, i, i, i, i, i)

            expectedParamsOne.append(i)
            expectedParamsTwo.append((i, i))
            expectedParamsThree.append((i, i, i))
            expectedParamsFour.append((i, i, i, i))
            expectedParamsFive.append((i, i, i, i, i))
            expectedParamsSix.append((i, i, i, i, i, i))
            expectedParamsSeven.append((i, i, i, i, i, i, i))
            expectedParamsEight.append((i, i, i, i, i, i, i, i))
            expectedParamsNine.append((i, i, i, i, i, i, i, i, i))
            expectedParamsTen.append((i, i, i, i, i, i, i, i, i, i))

            expectedReturnsOne.append(i)
            expectedReturnsTwo.append(i + i)
            expectedReturnsThree.append(i + i + i)
            expectedReturnsFour.append(i + i + i + i)
            expectedReturnsFive.append(i + i + i + i + i)
            expectedReturnsSix.append(i + i + i + i + i + i)
            expectedReturnsSeven.append(i + i + i + i + i + i + i)
            expectedReturnsEight.append(i + i + i + i + i + i + i + i)
            expectedReturnsNine.append(i + i + i + i + i + i + i + i + i)
            expectedReturnsTen.append(i + i + i + i + i + i + i + i + i + i)
        }

        mockedStruct
            .expect(\.returnOne)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsOne)
            .returning(expectedReturnsOne)
        mockedStruct
            .expect(\.addTwo)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsTwo)
            .returning(expectedReturnsTwo)
        mockedStruct
            .expect(\.addThree)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsThree)
            .returning(expectedReturnsThree)
        mockedStruct
            .expect(\.addFour)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsFour)
            .returning(expectedReturnsFour)
        mockedStruct
            .expect(\.addFive)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsFive)
            .returning(expectedReturnsFive)
        mockedStruct
            .expect(\.addSix)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsSix)
            .returning(expectedReturnsSix)
        mockedStruct
            .expect(\.addSeven)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsSeven)
            .returning(expectedReturnsSeven)
        mockedStruct
            .expect(\.addEight)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsEight)
            .returning(expectedReturnsEight)
        mockedStruct
            .expect(\.addNine)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsNine)
            .returning(expectedReturnsNine)
        mockedStruct
            .expect(\.addTen)
            .toBeCalled(exactly: 1000)
            .with(expectedParamsTen)
            .returning(expectedReturnsTen)
    }
}
