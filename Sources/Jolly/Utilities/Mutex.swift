import Foundation

public struct Mutex {
    var name: String = UUID().uuidString
    var lockReason: String? = nil

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
