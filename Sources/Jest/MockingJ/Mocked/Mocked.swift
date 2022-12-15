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
    var closureInvocationRecord: [PartialKeyPath<Mockable>: [Any]] = .init()
    @usableFromInline
    var memberFnStorage: [String: Any] = .init()
    @usableFromInline
    var memberFnInvocationRecord: [String: [Any]] = .init()
    @usableFromInline
    var accessTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var writeTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var memberFnInvocationTimeRecord: [String: [TimeInterval]] = .init()
    @usableFromInline
    var closureInvocationTimeRecord: [PartialKeyPath<Mockable>: [TimeInterval]] = .init()
    @usableFromInline
    var throwRecord: [PartialKeyPath<Mockable>: [Error]] = .init()

    init(mocking mocked: Mockable) {
        self.mocked = mocked
    }
}
