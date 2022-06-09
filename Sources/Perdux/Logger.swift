import Foundation
@_exported import os.log

public extension os.Logger {
    static var mainBundle = Bundle.main.bundleIdentifier!
}

public extension os.Logger {
    static let error = os.Logger(subsystem: mainBundle, category: "❗️Error")
    static let `default` = os.Logger(subsystem: os.Logger.mainBundle, category: "🔤 Default")
}

public enum _OSLogPrivacy: Equatable {
    case  auto, `public`, `private`, sensitive
}

@inlinable
@inline(__always)
public func log(_ message: String, logType: OSLogType = .default, category: os.Logger = .default, privacy: _OSLogPrivacy = .private) {
    // privacy argument must be resolved on compile time, hence ugly workaround
    // more info:
    // https://stackoverflow.com/questions/62675874/xcode-12-and-oslog-os-log-wrapping-oslogmessage-causes-compile-error-argumen#63036815
    switch privacy {
    case .private:
        //\(sender, align: .left(columns: 30), privacy: .public)
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .private)")
    case .public:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .public)")
    case .auto:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .auto)")
    case .sensitive:
        category.log(level: logType, "\(message, align: .left(columns: 30), privacy: .sensitive)")
    }
   
}


@inlinable
@inline(__always)
public func log<E: Error>(_ error: E) where E: CustomStringConvertible {
    log(error.description, logType: .error, category: .error)
}

@inlinable
@inline(__always)
public func log<Case>(_ case: Case) where Case: EnumReflectable  {
    let sender = "\(`case`.caseName) \(`case`.associatedValues)"
    log(sender, logType: .info)
}



public protocol EnumReflectable: CaseNameReflectable, AssociatedValuesReflectable {}

// reflicting enum cases
public protocol CaseNameReflectable {
    var caseName: String { get }
}
public extension CaseNameReflectable {
    var caseName: String {
        let mirror = Mirror(reflecting: self)
        guard let caseName = mirror.children.first?.label else {
            return "\(mirror.subjectType).\(self)"
        }
        return "\(mirror.subjectType).\(caseName)"
    }
}

public protocol AssociatedValuesReflectable {
    var associatedValues: [String: String] { get }
}
public extension AssociatedValuesReflectable {
    var associatedValues: [String: String] {
        var values = [String: String]()
        guard let associated = Mirror(reflecting: self).children.first else {
            return values
        }

        let children = Mirror(reflecting: associated.value).children
        for case let item in children {
            if let label = item.label {
                values[label] = String(describing: item.value)
            }
        }
        return values
    }
}
