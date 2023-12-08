import Foundation

public struct Mutex {
    @usableFromInline
    let lock: NSLock = .init()

    @inlinable
    @inline(__always)
    func atomize<T>(operation: () throws -> T) rethrows -> T {
        lock.lock()
        defer { lock.unlock() }
        return try operation()
    }

    @inlinable
    @inline(__always)
    func atomize<T>(expression: @autoclosure () throws -> T) rethrows -> T {
        lock.lock()
        defer { lock.unlock() }
        return try expression()
    }
}

// NSLock: Sendable, Trust Me Bro™️
extension Mutex: @unchecked Sendable {}
