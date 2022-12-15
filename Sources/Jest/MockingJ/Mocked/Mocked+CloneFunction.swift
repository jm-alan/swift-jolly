import XCTest

extension Mocked {
    func clone(function: Any, as name: String) {
        memberFnStorage[name] = function
    }

    @discardableResult
    func useClone<Param1, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1) throws -> Return {
        typealias FnType = (Param1) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1 in
            let value = try Self.time(
                castFn(param1),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(for: name, with: param1, returning: value)
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2) throws -> Return {
        typealias FnType = (Param1, Param2) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2 in
            let value = try Self.time(
                castFn(param1, param2),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(for: name, with: (param1, param2), returning: value)
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3) throws -> Return {
        typealias FnType = (Param1, Param2, Param3) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2, param3 in
            let value = try Self.time(
                castFn(param1, param2, param3),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(
                for: name,
                with: (param1, param2, param3),
                returning: value
            )
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3, Param4) throws -> Return {
        typealias FnType = (Param1, Param2, Param3, Param4) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2, param3, param4 in
            let value = try Self.time(
                castFn(param1, param2, param3, param4),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(
                for: name,
                with: (param1, param2, param3, param4),
                returning: value
            )
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Param5, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3, Param4, Param5) throws -> Return {
        typealias FnType = (Param1, Param2, Param3, Param4, Param5) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2, param3, param4, param5 in
            let value = try Self.time(
                castFn(param1, param2, param3, param4, param5),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(
                for: name,
                with: (param1, param2, param3, param4, param5),
                returning: value
            )
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Param5, Param6, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3, Param4, Param5, Param6) throws -> Return {
        typealias FnType = (Param1, Param2, Param3, Param4, Param5, Param6) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2, param3, param4, param5, param6 in
            let value = try Self.time(
                castFn(param1, param2, param3, param4, param5, param6),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(
                for: name,
                with: (param1, param2, param3, param4, param5, param6),
                returning: value
            )
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7) throws -> Return {
        typealias FnType = (Param1, Param2, Param3, Param4, Param5, Param6, Param7) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self] param1, param2, param3, param4, param5, param6, param7 in
            let value = try Self.time(
                castFn(param1, param2, param3, param4, param5, param6, param7),
                as: name,
                storingResultIn: &memberFnInvocationTimeRecord
            )
            makeMemberFnInvocationRecord(
                for: name,
                with: (param1, param2, param3, param4, param5, param6, param7),
                returning: value
            )
            return value
        }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) throws -> Return {
        typealias FnType = (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8)
            throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8 in
                let value = try Self.time(
                    castFn(param1, param2, param3, param4, param5, param6, param7, param8),
                    as: name,
                    storingResultIn: &memberFnInvocationTimeRecord
                )
                makeMemberFnInvocationRecord(
                    for: name,
                    with: (param1, param2, param3, param4, param5, param6, param7, param8),
                    returning: value
                )
                return value
            }
        return mockedFn
    }

    @discardableResult
    func useClone<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Param9, Return>(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws
        -> (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9
        ) throws -> Return
    {
        typealias FnType = (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9
        ) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9 in
                let value = try Self.time(
                    castFn(param1, param2, param3, param4, param5, param6, param7, param8, param9),
                    as: name,
                    storingResultIn: &memberFnInvocationTimeRecord
                )
                makeMemberFnInvocationRecord(
                    for: name,
                    with: (param1, param2, param3, param4, param5, param6, param7, param8, param9),
                    returning: value
                )
                return value
            }
        return mockedFn
    }

    @discardableResult
    func useClone<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8,
        Param9,
        Param10,
        Return
    >(
        _ name: String,
        returning: Return.Type = Return.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws
        -> (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9,
            Param10
        ) throws -> Return
    {
        typealias FnType = (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9,
            Param10
        ) throws -> Return
        guard let clonedFn = memberFnStorage[name] else {
            throw MockingJError("Failed to find cloned function \(name)", file: file, line: line)
        }
        guard let castFn = clonedFn as? FnType else {
            throw MockingJError(
                "Failed to cast cloned function \(describing: clonedFn) as \(FnType.self)",
                file: file,
                line: line
            )
        }
        let mockedFn: FnType = { [self]
            param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 in
                let value = try Self.time(
                    castFn(
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8,
                        param9,
                        param10
                    ),
                    as: name,
                    storingResultIn: &memberFnInvocationTimeRecord
                )
                makeMemberFnInvocationRecord(
                    for: name,
                    with: (
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8,
                        param9,
                        param10
                    ),
                    returning: value
                )
                return value
        }
        return mockedFn
    }
}
