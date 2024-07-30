public enum MaybeData<T, E> where E: Error {
    case initial(_ stub: T? = .none)
    case success(_ result: T)
    case failure(_ error: E)

    public var value: T? {
        switch self {
            case let .success(val): return val
            default: return .none
        }
    }

    public var error: E? {
        switch self {
            case let .failure(err): return err
            default: return .none
        }
    }
}

extension MaybeData: IAnimatableValue {
    public var asAnimatableValue: Int {
        switch self {
            case .initial: return 0
            case .success: return 1
            case .failure: return -1
        }
    }
}
