public extension DefaultStringInterpolation {
    @inlinable
    mutating func appendInterpolation<Object>(describing object: Object?) {
        appendInterpolation(String(describing: object))
    }
}
