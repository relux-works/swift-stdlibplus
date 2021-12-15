import Foundation
import os.log

public func log(sender: Any, message: String) {
    Logger.log(sender: sender, message: message)
}

public func log(sender: String, message: String) {
    Logger.log(sender: sender, message: message)
}

public func log(sender: String = #fileID, functionName: String = #function, _ message: String, _ category: os.Logger = .reduxMsg) {
    let stroppedFileId = sender
            .replacingOccurrences(of: ".swift", with: "")
    let strippedFunctionName = functionName
            .replacingOccurrences(of: ".swift", with: "")
    Logger.log(sender: "\(stroppedFileId) \(strippedFunctionName)", message: message, category: category)
}

public func log(sender: String = #fileID, _ error: Error, comment: String = "", _ category: os.Logger = .reduxMsg) {
    let strippedFileId = sender
            .replacingOccurrences(of: ".swift", with: "")
    Logger.log(sender: strippedFileId, error: error, category: category)
}

public func log<Action: PerduxAction>(_ action: Action, _ category: os.Logger = .reduxMsg) {
    Logger.log(action, category)
}

public extension os.Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    // global loosely structured categories
    static let reduxAction = os.Logger(subsystem: subsystem, category: "🔄 Perdux Action")
    static let reduxEffect = os.Logger(subsystem: subsystem, category: "🔀 Perdux Effect")
    static let reduxState = os.Logger(subsystem: subsystem, category: "💿 Perdux State")
    static let reduxMsg = os.Logger(subsystem: subsystem, category: "ℹ️ Msg")
    static let error = os.Logger(subsystem: subsystem, category: "❗️Error")

    // logical categories
    static let ui = os.Logger(subsystem: subsystem, category: "⏯ UI")
    static let api = os.Logger(subsystem: subsystem, category: "↕️ API")
    static let socket = os.Logger(subsystem: subsystem, category: "🌐 Socket")
    static let tokenProvider = os.Logger(subsystem: subsystem, category: "🔑 TokenProvider")
}

open class LoggerConfig {
    let enabled: Bool
    let exclusions: [String]

    public init(
            enabled: Bool = false,
            exclusions: [String] = []
    ) {
        self.enabled = enabled
        self.exclusions = exclusions
    }
}

open class Logger {
    public static var config: LoggerConfig = .init()
    public class func log(error: NSException, data: [String: Any] = [:]) {
        guard config.enabled else { return }
        let msg =  """
                   Error: \(type(of: error)) at \(currentTime): name: \(error.name) 
                       reason: \(error.reason ?? "nil")
                       data: \(data)
                       callstack: \n\(error.callStackSymbols.joined(separator: "\n"))
                   """

        guard checkIsExcluded(msg).not else { return }

        print(msg)
    }

    public class func log(error: Error) {
        guard config.enabled else { return }

        let msg = "Error: \(type(of: error)) at \(currentTime): \(error.localizedDescription)"

        guard checkIsExcluded(msg).not else { return }

        print(msg)
    }

    public class func log(sender: String, error: Error, category logger: os.Logger) {
        guard config.enabled else { return }

        let msg = "Error: \(type(of: error)) \(error.localizedDescription)"

        guard checkIsExcluded(sender).not else { return }
        guard checkIsExcluded(msg).not else { return }

        logger.error("\(sender, align: .left(columns: 30), privacy: .public) \(msg, align: .left(columns: 30), privacy: .public)")
    }

    public class func log(state: PerduxState, fieldName: String, event: PerduxState.ChangesType, oldValue: Any?, newValue: Any?) {
        guard config.enabled else { return }

        let sender = "\(Mirror(reflecting: state).subjectType)"
        let oldValue = "\(oldValue ?? "nil")".prefix(256)
        let newValue = "\(newValue ?? "nil")".prefix(256)
        let msg =
                """
                '\(fieldName)' \(event)
                  from: \(oldValue)
                  to: \(newValue)
                """

        guard checkIsExcluded(sender).not else { return }
        guard checkIsExcluded(msg).not else { return }

        os.Logger.reduxState.info("\(sender, align: .left(columns: 30)) \(msg, align: .left(columns: 30))")
    }

    public class func log(sender: Any, message: String) {
        guard config.enabled else { return }

        let sender = "\(Mirror(reflecting: sender).subjectType)"

        guard checkIsExcluded(sender).not else { return }
        guard checkIsExcluded(message).not else { return }

        os.Logger.reduxMsg.info("\(sender, align: .left(columns: 30)) \(message, align: .left(columns: 30))")
    }

    public class func log(sender: String, message: String) {
        guard config.enabled else { return }
        guard checkIsExcluded(sender).not else { return }
        guard checkIsExcluded(message).not else { return }

        os.Logger.reduxMsg.info("\(sender, align: .left(columns: 30)) \(message, align: .left(columns: 30))")
    }

    public class func log(sender: String, message: String, category logger: os.Logger) {
        guard config.enabled else { return }

        guard checkIsExcluded(sender).not else { return }
        guard checkIsExcluded(message).not else { return }

        logger.info("\(sender, align: .left(columns: 30), privacy: .public) \(message, align: .left(columns: 30), privacy: .public)")
    }

    public class func log(sender: Any, message: String, data: String) {
        guard config.enabled else { return }

        let sender = "\(Mirror(reflecting: sender).subjectType)"
        let msg = "\(message): \n\t \(data)"

        guard checkIsExcluded(msg).not else { return }

        os.Logger.reduxMsg.info("\(sender, align: .left(columns: 30)) \(msg, align: .left(columns: 30))")
    }

    public class func log<Action: PerduxAction>(_ action: Action, _ category: os.Logger = .reduxAction) {
        guard config.enabled else { return }
        let sender = "\(type(of: action))"
        let msg = "\(action)".prefix(1024)

        guard checkIsExcluded(msg).not else { return }

        category.info("\(sender, align: .left(columns: 30)) \(msg, align: .left(columns: 30))")
    }

    public class func log(_ effects: [PerduxEffect]) {
        effects
            .forEach(log)
    }

    public class func log(_ effect: PerduxEffect) {
        guard config.enabled else { return }

        let sender = "\(type(of: effect))"
        let msg = "\(effect)"

        guard checkIsExcluded(msg).not else { return }

        os.Logger.reduxEffect.info("\(sender, align: .left(columns: 30)) \(msg, align: .left(columns: 30))")
    }

    private class var currentTime: String {
        Date().timeWithMillis
    }

    private class var currentFullDate: String {
        Date().toString(as: "EEE',' dd MMM yyyy HH':'mm':'ss z")
    }

    private class func checkIsExcluded(_ str: String.SubSequence) -> Bool {
        config.exclusions
                .first { str.contains($0) }
                .isNotNil
    }
    private class func checkIsExcluded(_ str: String) -> Bool {
        config.exclusions
                .first { str.contains($0) }
                .isNotNil
    }
}
