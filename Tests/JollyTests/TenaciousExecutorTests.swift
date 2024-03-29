@testable import Jolly
import XCTest

final class TenaciousExecutorTests: XCTestCase {
    struct ExecutorTestError: Error {
        let message: String

        @inline(__always)
        static func from(attempts: Int) -> Self {
            .init(message: "Attempt \(attempts); sleeping")
        }
    }

    @inline(__always)
    func testSimpleFixedExecutor() throws {
        var attempts = 0
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                guard attempts == 5 else {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(name: "simple fixed test")
            .with(backoffMethod: .fixed(300))
            .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.2,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testSimpleExponentialExecutor() throws {
        var attempts = 0
        let counter = {
            attempts += 1
            guard attempts == 5 else {
                throw ExecutorTestError.from(attempts: attempts)
            }
            return attempts
        }
        let countTo5: TenaciousExecutor<Int> =
            try .performing(counter())
                .with(name: "simple exponential test")
                .with(backoffMethod: .exponential(100))
                .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.5,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testSimpleFixedIntervalExecutor() throws {
        var attempts = 0
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                guard attempts == 5 else {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(name: "simple fixed interval test")
            .with(backoffMethod: .fixedUniformInterval(250...500))
            .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testSimpleExponentialIntervalExecutor() throws {
        var attempts = 0
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                guard attempts == 5 else {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(name: "simple exponential interval test")
            .with(backoffMethod: .exponentialUniformInverval(100...175))
            .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.5,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testSimpleCustomExecutor() throws {
        var attempts = 0
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                guard attempts == 5 else {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(name: "simple custom test")
            .with(backoffMethod: .custom { attempts, _, _, _ in
                attempts * 150
            })
            .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.5,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testMaxBackoffTime() throws {
        var attempts = 0
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                guard attempts == 5 else {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(name: "max backoff test")
            .with(backoffMethod: .exponential(100))
            .with(backoffTimeLimitedTo: 500)
            .with(attemptsLimitedTo: 5)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.2,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
    }

    @inline(__always)
    func testMinLifetime() throws {
        Stopwatch.start(timer: "min lifetime timer")

        let countTo5: TenaciousExecutor<Void> =
            .performing {
                guard Stopwatch.get(timer: "min lifetime timer") >= 1.5 else {
                    throw ExecutorTestError(message: "Required lifetime not yet met")
                }
            }
            .with(name: "min lifetime test")
            .with(backoffMethod: .exponential(100))
            .with(backoffTimeLimitedTo: 500)
            .with(minimumTotalLifetime: 1500)

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 1.5,
            "Actual time difference was \(timedResult.duration)"
        )
    }

    @inline(__always)
    func testCustomErrorHandler() throws {
        var attempts = 0
        var errors: [Error] = []
        let countTo5: TenaciousExecutor<Int> =
            .performing {
                attempts += 1
                if attempts < 5 {
                    throw ExecutorTestError.from(attempts: attempts)
                }
                return attempts
            }
            .with(backoffMethod: .fixed(500))
            .with(name: "error handler test")
            .with(backoffTimeLimitedTo: 3000)
            .with(attemptsLimitedTo: 5)
            .handlingErrors { errors.append($1) }

        let timedResult = try Stopwatch.time(countTo5.run())

        XCTAssertTrue(
            timedResult.duration >= 2,
            "Actual time difference was \(timedResult.duration)"
        )
        XCTAssertEqual(attempts, timedResult.value)
        XCTAssertEqual(attempts, 5)
        XCTAssertEqual(errors.count, 4)
    }

    @inline(__always)
    func testMissingOperation() {
        let badExecutor: TenaciousExecutor<Void> = .init()
        XCTAssertThrowsError(try badExecutor.run())
    }

    @inline(__always)
    func testExhaustedAttempts() {
        let noAttempts: TenaciousExecutor<Void> =
            .performing { throw ExecutorTestError(message: "Should fail immediately") }
                .with(attemptsLimitedTo: 0)

        XCTAssertThrowsError(try noAttempts.run())
    }
}
