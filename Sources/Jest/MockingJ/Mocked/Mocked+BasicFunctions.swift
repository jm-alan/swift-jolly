import Foundation
import Jolly

extension Mocked {
    @inlinable
    @inline(__always)
    static func time<T>(
        _ operation: @autoclosure () throws -> T,
        originatingFrom mockableLocation: PartialKeyPath<Mockable>,
        storingResultIn storage: inout [PartialKeyPath<Mockable>: [TimeInterval]]
    ) rethrows -> T {
        let timeResult = try Stopwatch.time(operation())
        if storage[mockableLocation] == nil {
            storage[mockableLocation] = [timeResult.duration]
        } else {
            storage[unsafe: mockableLocation].append(timeResult.duration)
        }
        return timeResult.value
    }

    @inlinable
    @inline(__always)
    static func time<T>(
        _ operation: @autoclosure () throws -> T,
        as name: String,
        storingResultIn storage: inout [String: [TimeInterval]]
    ) rethrows -> T {
        let timeResult = try Stopwatch.time(operation())
        if storage[name] == nil {
            storage[name] = [timeResult.duration]
        } else {
            storage[unsafe: name].append(timeResult.duration)
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
            accessRecord[unsafe: key].append(value)
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
            writeRecord[unsafe: key].append(value)
        }
    }

    @inlinable
    @inline(__always)
    func makeClosureInvocationRecord<Params, Return>(
        for key: PartialKeyPath<Mockable>,
        with parameters: Params,
        returning returnValue: Return
    ) {
        if closureInvocationRecord[key] == nil {
            closureInvocationRecord[key] = [(parameters, returnValue)]
        } else {
            closureInvocationRecord[unsafe: key].append((parameters, returnValue))
        }
    }

    @inlinable
    @inline(__always)
    func makeMemberFnInvocationRecord<Params, Return>(
        for name: String,
        with parameters: Params,
        returning returnValue: Return
    ) {
        if memberFnInvocationRecord[name] == nil {
            memberFnInvocationRecord[name] = [(parameters, returnValue)]
        } else {
            memberFnInvocationRecord[unsafe: name].append((parameters, returnValue))
        }
    }

    @inlinable
    @inline(__always)
    func expect<T>(_ key: KeyPath<Mockable, T>) -> PropertyAssertionBuilder<Mockable, T> {
        PropertyAssertionBuilder(
            accessor: key,
            value: mocked[keyPath: key],
            accessRecord: accessRecord,
            writeRecord: writeRecord,
            invocationRecord: closureInvocationRecord
        )
    }

    @inlinable
    @inline(__always)
    func expect(_ memberFnName: String) -> InvocableAssertionBuilder<Any> {
        InvocableAssertionBuilder(
            memberFnName: memberFnName,
            memberFn: memberFnStorage[unsafe: memberFnName],
            invocationRecord: memberFnInvocationRecord
        )
    }
}
