import Foundation

public protocol PerduxAction: EnumReflectable {
    static var executionQueue: DispatchQueue { get }
}
