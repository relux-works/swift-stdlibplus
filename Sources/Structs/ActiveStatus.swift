
public enum ActiveStatus: String {
    case inactive
    case activating
    case active
    case deactivating
}

public extension ActiveStatus {
    static func from(toggle: Bool) -> Self {
        switch toggle {
        case true: return .active
        case false: return .inactive
        }
    }
}

public extension ActiveStatus {
    var asProgress: Self {
        switch self {
        case .active, .activating: return .activating
        case .inactive, .deactivating: return .deactivating
        }
    }

    var finite : Self {
        switch self {
        case .active, .activating: return .active
        case .inactive, .deactivating: return .inactive
        }
    }

    var inversed: Self {
        switch self {
        case .inactive: return .active
        case .active: return .inactive
        case .activating: return .activating
        case .deactivating: return .deactivating
        }
    }
}

public extension ActiveStatus {
    var inProgress: Bool {
        switch self {
            case .activating, .deactivating: true
            case .active, .inactive: false
        }
    }
}

extension ActiveStatus: Codable {}

extension ActiveStatus: Identifiable {
    public var id: String { self.rawValue }
}
