public extension DefaultStringInterpolation {
    @inline(__always)
    mutating func appendInterpolation<Object>(describing object: Object?) {
        appendInterpolation(String(describing: object))
    }
}
