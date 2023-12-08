public extension RandomAccessCollection {
    @inlinable
    @inline(__always)
    subscript(safe range: Range<Index>) -> SubSequence {
        var constrainedLowerIndex: Index = startIndex
        var constrainedUpperIndex: Index = endIndex
        if
            range.lowerBound >= startIndex,
            range.lowerBound < endIndex
        { constrainedLowerIndex = range.lowerBound }
        if
            range.upperBound >= startIndex,
            range.upperBound < endIndex
        { constrainedUpperIndex = range.upperBound }
        return self[constrainedLowerIndex..<constrainedUpperIndex]
    }

    @inlinable
    @inline(__always)
    subscript(safe range: ClosedRange<Index>) -> SubSequence {
        return self[safe: range.lowerBound..<index(range.upperBound, offsetBy: 1)]
    }

    @inlinable
    @inline(__always)
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
