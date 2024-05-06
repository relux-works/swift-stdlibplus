import Foundation

public enum DeviceEnv {
    case prod
    case dev

    public static var isSimulator : Bool {
        TARGET_OS_SIMULATOR != 0
    }

    public var label: String {
        switch self {
        case .prod: return "PROD"
        case .dev: return "DEV"
        }
    }

    public static var env: DeviceEnv {
        #if DEBUG
            return .dev
        #else
            return .prod
        #endif
    }
}