public extension Optional {
    var isNotNil: Bool {
        switch self {
        case .none: return false
        case .some(_): return  true
        }
    }

    var isNil: Bool {
        switch self {
        case .none: return true
        case .some(_): return false
        }
    }
}


public extension Optional {
    enum OptionalErr: Error {
        case failedToUnwrap
    }

    var forceUnwrap: Wrapped { self! }

    var value: Wrapped {
        get throws {
            guard let value = self else {
                throw OptionalErr.failedToUnwrap
            }

            return value
        }
    }

    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else {
            throw errorExpression()
        }

        return value
    }
}