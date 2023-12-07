@inlinable
@inline(__always)
public func expandIndentation(depth: Int, spacing: Int = 2) -> String {
    var composed = ""

    for _ in 0..<depth {
        for _ in 0..<spacing {
            composed += " "
        }
    }

    return composed
}
