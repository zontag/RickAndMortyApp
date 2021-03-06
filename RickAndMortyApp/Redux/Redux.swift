import Foundation
import ReactiveSwift
import ReactiveCocoa

// MARK: - Reducer
struct Reducer<State, Action> {
    
    typealias ReducerClosure<State, Action> = (
        inout MutableProperty<State>,
        Action,
        Environment)
        -> SignalProducer<Action, Never>?
    
    var environment: Environment
    var reducer: ReducerClosure<State, Action>
    
    func callAsFunction(_ state: inout MutableProperty<State>, _ action: Action) -> SignalProducer<Action, Never>? {
        return reducer(&state, action, environment)
    }
}

// MARK: - Store
final class Store<State, Action> {
    private let (lifetime, token) = Lifetime.make()
    private let reducer: Reducer<State, Action>
    
    var state: MutableProperty<State>
    
    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = MutableProperty<State>(initialState)
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer(&state, action)?
            .take(during: lifetime)
            .observe(on: UIScheduler())
            .startWithValues(send)
    }
}
