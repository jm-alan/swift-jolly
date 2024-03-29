import Foundation

public class TenaciousExecutor<T> {
    @usableFromInline
    var name: String = UUID().uuidString
    @usableFromInline
    var attempts: Int = 0
    @usableFromInline
    var maxAttempts: Int = .max
    @usableFromInline
    var lastError: Error!
    @usableFromInline
    var errors: [Error] = []
    @usableFromInline
    var backoffMethod: BackoffMethod = .fixed(0)
    @usableFromInline
    var operation: (() throws -> T)?
    @usableFromInline
    var maxBackoffTime: Int = .max
    @usableFromInline
    var errorHandler: (TenaciousExecutor, Error) -> Void = {
        print("Executor '\($0.name)' failed on attempt \($0.attempts) with error: \($1)")
    }

    @usableFromInline
    init() {}

    @inlinable
    @inline(__always)
    func with(name: String) -> Self {
        self.name = name
        return self
    }

    @inlinable
    @inline(__always)
    func with(backoffMethod: BackoffMethod) -> Self {
        self.backoffMethod = backoffMethod
        return self
    }

    @inlinable
    @inline(__always)
    func with(attemptsLimitedTo maxAttempts: Int) -> Self {
        self.maxAttempts = maxAttempts
        return self
    }

    @inlinable
    @inline(__always)
    func with(backoffTimeLimitedTo maxBackoffTime: Int) -> Self {
        self.maxBackoffTime = maxBackoffTime
        return self
    }

    @inlinable
    @inline(__always)
    func with(minimumTotalLifetime: Int) -> Self {
        var computedAttempts = 0
        var totalLifetime = 0
        var currentBackoffTime = 0
        while
            totalLifetime < minimumTotalLifetime
            && currentBackoffTime < maxBackoffTime
        {
            computedAttempts += 1
            totalLifetime += currentBackoffTime
            currentBackoffTime = getNextRetryInterval(given: computedAttempts)
        }
        while totalLifetime < minimumTotalLifetime {
            computedAttempts += 1
            totalLifetime += maxBackoffTime
        }
        maxAttempts = computedAttempts
        return self
    }

    @inlinable
    @inline(__always)
    func handlingErrors(
        with errorHandler: @escaping (TenaciousExecutor, Error) -> Void
    ) -> TenaciousExecutor {
        self.errorHandler = errorHandler
        return self
    }

    @inlinable
    @inline(__always)
    static func performing(
        _ operation: @escaping () throws -> T
    ) -> TenaciousExecutor {
        let executor: TenaciousExecutor = .init()
        executor.operation = operation
        return executor
    }

    @inlinable
    @inline(__always)
    static func performing(
        _ operation: @escaping @autoclosure () throws -> T
    ) -> TenaciousExecutor {
        return performing(operation)
    }

    @inlinable
    @inline(__always)
    func getNextRetryInterval(given currentAttempts: Int? = nil) -> Int {
        let attempts = currentAttempts ?? self.attempts
        switch backoffMethod {
        case let .fixed(backoffTime):
            return backoffTime <> maxBackoffTime
        case let .fixedUniformInterval(interval):
            return .random(in: interval) <> maxBackoffTime
        case let .exponential(initialBackoffTime, growthFactor):
            var computedBackoffTime = initialBackoffTime
            for _ in 1..<attempts {
                computedBackoffTime *= growthFactor
            }
            return computedBackoffTime <> maxBackoffTime
        case let .exponentialUniformInverval(interval, growthFactor):
            var computedBackoffTime: Int = .random(in: interval)
            for _ in 1..<attempts {
                computedBackoffTime *= growthFactor
            }
            return computedBackoffTime <> maxBackoffTime
        case let .custom(calculator):
            let customTime = calculator(
                attempts,
                maxAttempts,
                maxBackoffTime,
                lastError
            )
            return customTime <> maxBackoffTime
        }
    }

    @inlinable
    @inline(__always)
    func run() throws -> T {
        guard let operation = operation else {
            throw ExecutorConfigurationError(
                message: "No operation was provided to execute"
            )
        }

        repeat {
            do {
                attempts += 1
                return try operation()
            } catch {
                lastError = error
                errors.append(error)
                errorHandler(self, error)
                Thread.sleep(forTimeInterval: .init(getNextRetryInterval()) / 1000.0)
            }
        } while attempts < maxAttempts
        throw lastError
    }

    @usableFromInline
    struct ExecutorConfigurationError: Error {
        let message: String

        @usableFromInline
        init(message: String) { self.message = message }
    }

    public enum BackoffMethod {
        /// Indicates that the executor should wait a fixed amount of time between each
        /// attempt
        ///
        /// - Parameters:
        ///     - Int: The number of milliseconds the executor will sleep between attempts
        case fixed(Int)

        /// Indicates that the executor should wait a varying amount of time between each
        /// attempt
        ///
        /// - Parameters:
        ///     - ClosedRange: The lower and upper bounds in milliseconds, inclusive, from
        ///         which each attempt wait time will be chosen at random
        case fixedUniformInterval(ClosedRange<Int>)

        /// Indicates that the executor attempt wait time should increase geometrically from
        /// a given initial wait time
        ///
        /// - Parameters:
        ///     - Int: The initial number of milliseconds the executor will wait
        ///     - Int: (optional) The exponential factor by which the initial attempt wait time
        ///         will grow. Defaults to 2
        case exponential(Int, Int = 2)

        /// Indicates that the executor attempt wait time should increase geometrically, with
        /// an initial time chosen at random from the provided range, inclusive
        ///
        /// - Parameters:
        ///     - ClosedRange: The lower and upper bounds in milliseconds, inclusive, from
        ///         which the initial attempt wait time will be chosen at random
        ///     - Int: (optional) The exponential factor by which the initial attempt wait time
        ///         will grow. Defaults to 2
        case exponentialUniformInverval(ClosedRange<Int>, Int = 2)

        /// A means for providing a custom calculator to determine the next retry time
        ///
        /// - Parameters:
        ///     - CustomBackoffGenerator: See
        /// ``TenaciousExecutor/BackoffMethod/CustomBackoffGenerator``
        case custom(CustomBackoffGenerator)

        /// - Parameters:
        ///     - Int: How many times the operation has been attempted
        ///     - Int: The maximum number of attempts permitted
        ///     - Int: The maximum amount of time the executor can wait on
        ///         a single iteration
        ///     - Error: The last error that was thrown by the previous attempt
        ///
        /// - Returns: The number of milliseconds the executor should wait before
        ///         attempting the operation again
        public typealias CustomBackoffGenerator = (Int, Int, Int, Error) -> Int
    }
}
