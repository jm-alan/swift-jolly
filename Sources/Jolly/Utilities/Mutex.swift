import Foundation

public struct Mutex {
    @usableFromInline
    let lock: NSLock = .init()

    @inlinable
    @inline(__always)
    func atomize(operation: () throws -> Void) rethrows {
        lock.lock()
        defer { lock.unlock() }
        try operation()
    }

    @inlinable
    @inline(__always)
    func atomize(expression: @autoclosure () throws -> Void) rethrows {
        lock.lock()
        defer { lock.unlock() }
        try expression()
    }
}

// NSLock: Sendable, Trust Me Bro™️
extension Mutex: @unchecked Sendable {}
