import Foundation

public enum ErrorViolation: String {
    
    /// some problems with authentication
    case authProblem = "AuthProblem"
    
    /// nothing special, we can ignore it and don't care
    case silent = "Silent"
    
    /// something went wrong and we have to log it without any user reaction
    case warning = "Warning"
    
    /// something serious went wrong, we have to log it and notify user
    case error = "Error"
    
    /// something critical was happen, we have to log it and relaunch app
    case fatal = "Fatal"
}
