import Foundation

public enum Stopwatch {
    @inlinable
    @inline(__always)
    public static func time<T>(operation: () throws -> T) rethrows -> StopwatchResult<T> {
        let start = Date()
        let value = try operation()
        let duration = Date().timeIntervalSince(start)
        return .init(value: value, duration: duration)
    }

    @inlinable
    @inline(__always)
    public static func time<T>(
        _ operation: @autoclosure () throws -> T
    ) rethrows -> StopwatchResult<T> {
        let start = Date()
        let value = try operation()
        let duration = Date().timeIntervalSince(start)
        return .init(value: value, duration: duration)
    }

    @inlinable
    @inline(__always)
    public static func time<T>(
        operation: () async throws -> T
    ) async rethrows -> StopwatchResult<T> {
        let start = Date()
        let value = try await operation()
        let duration = Date().timeIntervalSince(start)
        return .init(value: value, duration: duration)
    }

    @inlinable
    @inline(__always)
    public static func time<T>(
        _ operation: @autoclosure () async throws -> T
    ) async rethrows -> StopwatchResult<T> {
        let start = Date()
        let value = try await operation()
        let duration = Date().timeIntervalSince(start)
        return .init(value: value, duration: duration)
    }

    @usableFromInline
    static var timerStorage: [String: Timer] = [:]

    @inlinable
    @inline(__always)
    static func start(timer: String) {
        timerStorage[timer] = .init()
    }

    @inlinable
    @inline(__always)
    static func stop(timer: String) {
        timerStorage[unsafe: timer].stop()
    }

    @inlinable
    @inline(__always)
    static func get(timer: String) -> TimeInterval {
        Date().timeIntervalSince(timerStorage[unsafe: timer].startTime)
    }

    @usableFromInline
    struct Timer {
        @usableFromInline
        let startTime: Date = .init()
        var stopped: Bool = .init()
        var duration: TimeInterval = .init()

        @usableFromInline
        @inline(__always)
        mutating func stop() {
            duration = Date().timeIntervalSince(startTime)
            stopped = true
        }

        @usableFromInline
        init() {}
    }
}

public struct StopwatchResult<T> {
    public let value: T
    public let duration: TimeInterval

    @inlinable
    @inline(__always)
    public init(value: T, duration: TimeInterval) {
        self.value = value
        self.duration = duration
    }
}
