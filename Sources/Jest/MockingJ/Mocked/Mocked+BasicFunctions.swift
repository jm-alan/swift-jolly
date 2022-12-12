import Foundation
import Jolly

extension Mocked { @inlinable
    @inline(__always)
    static func time<T>(
        _ operation: @autoclosure () throws -> T,
        originatingFrom mockableLocation: PartialKeyPath<Mockable>,
        storingResultIn storage: inout [PartialKeyPath<Mockable>: [TimeInterval]]
    ) rethrows -> T {
        let timeResult: StopwatchResult<T> = try Stopwatch.time(operation())
        if storage[mockableLocation] == nil {
            storage[mockableLocation] = [timeResult.duration]
        } else {
            storage[mockableLocation]!.append(timeResult.duration)
        }
        return timeResult.value
    }

    @inlinable
    @inline(__always)
    func makeAccessRecord<T>(
        for key: PartialKeyPath<Mockable>,
        of value: T
    ) {
        if accessRecord[key] == nil {
            accessRecord[key] = [value]
        } else {
            accessRecord[key]!.append(value)
        }
    }

    @inlinable
    @inline(__always)
    func makeWriteRecord<T>(
        for key: PartialKeyPath<Mockable>,
        of value: T
    ) {
        if writeRecord[key] == nil {
            writeRecord[key] = [value]
        } else {
            writeRecord[key]!.append(value)
        }
    }

    @inlinable
    @inline(__always)
    func makeInvocationRecord<Params, Return>(
        for key: PartialKeyPath<Mockable>,
        with parameters: Params,
        returning returnValue: Return
    ) {
        if invocationRecord[key] == nil {
            invocationRecord[key] = [(parameters, returnValue)]
        } else {
            invocationRecord[key]!.append((parameters, returnValue))
        }
    }

    @inlinable
    @inline(__always)
    func expect<T>(_ key: KeyPath<Mockable, T>) -> AssertionBuilder<Mockable, T> {
        AssertionBuilder(mocked, key, accessRecord, writeRecord, invocationRecord)
    }
}
