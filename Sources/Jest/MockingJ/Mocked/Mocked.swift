import Foundation
import Jolly

final class Mocked<Mockable> {
    @usableFromInline
    var mocked: Mockable
    @usableFromInline
    var accessRecord: [PartialKeyPath<Mockable>: [Any]] = .init()
    @usableFromInline
    var writeRecord: [PartialKeyPath<Mockable>: [Any]] = .init()
    @usableFromInline
    var invocationRecord: [PartialKeyPath<Mockable>: [Any]] = .init()
    @usableFromInline
    var accessTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var writeTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var invocationTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var throwRecord: [PartialKeyPath<Mockable>: [Error]] = .init()

    init(mocking mocked: Mockable) {
        self.mocked = mocked
    }
}
