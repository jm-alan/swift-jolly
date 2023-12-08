prefix operator ==

@inlinable
@inline(__always)
public prefix func == <E>(_ rhs: E) -> ((E) -> Bool) where E: Equatable { { $0 == rhs } }
