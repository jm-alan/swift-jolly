public protocol SimpleInitializable {
    init()
}

extension Int: SimpleInitializable {}
extension Int8: SimpleInitializable {}
extension Int16: SimpleInitializable {}
extension Int32: SimpleInitializable {}
extension Int64: SimpleInitializable {}
extension UInt: SimpleInitializable {}
extension UInt8: SimpleInitializable {}
extension UInt16: SimpleInitializable {}
extension UInt32: SimpleInitializable {}
extension UInt64: SimpleInitializable {}
extension String: SimpleInitializable {}
extension Bool: SimpleInitializable {}
extension Float: SimpleInitializable {}
extension Float16: SimpleInitializable {}
extension Float64: SimpleInitializable {}
extension Array: SimpleInitializable {}
extension Dictionary: SimpleInitializable {}
