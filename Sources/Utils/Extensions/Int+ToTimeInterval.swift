import Foundation

 public extension Int {
     enum SecondsToStringPresentation {
         case secondsOnly
         case minutes
         case hours
         case dynamic
     }

     func secondsToString(_ presentation: SecondsToStringPresentation) -> String {
         let hours = self/3600
         let minutes = (self%3600)/60
         let seconds = (self%3600)%60

         switch presentation {
         case .secondsOnly:
             return self.description
         case .minutes:
             return String(format:"%02i:%02i", minutes, seconds)
         case .hours:
             return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
         case .dynamic:
             if hours > 0 {
                 return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
             } else if minutes > 0 {
                 return String(format:"%02i:%02i", minutes, seconds)
             } else {
                 return String(format:"%02i", seconds)
             }
         }
     }
 }

public extension UInt {
    enum SecondsToStringPresentation {
        case secondsOnly
        case minutes
        case hours
        case dynamic
    }

    func secondsToString(_ presentation: SecondsToStringPresentation) -> String {
        let hours = self/3600
        let minutes = (self%3600)/60
        let seconds = (self%3600)%60

        switch presentation {
        case .secondsOnly:
            return self.description
        case .minutes:
            return String(format:"%02i:%02i", minutes, seconds)
        case .hours:
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        case .dynamic:
            if hours > 0 {
                return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
            } else if minutes > 0 {
                return String(format:"%02i:%02i", minutes, seconds)
            } else {
                return String(format:"%02i", seconds)
            }
        }
    }
}
