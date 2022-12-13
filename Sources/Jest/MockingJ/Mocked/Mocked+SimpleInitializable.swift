import Jolly

extension Mocked: SimpleInitializable where Mockable: SimpleInitializable {
    convenience init() {
        self.init(mocking: .init())
    }
}
