public extension Sequence {
    @inlinable
    @inline(__always)
    func allSatisfy<C>(
        _ predicate: KeyValComparator<Element, C>
    ) -> Bool {
        allSatisfy(predicate.getValue(comparing:))
    }

    @inlinable
    @inline(__always)
    func filter<C>(
        _ comparator: KeyValComparator<Element, C>
    ) -> [Self.Element] where C: Comparable {
        filter(comparator.getValue)
    }
}
