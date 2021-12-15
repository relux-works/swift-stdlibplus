import Foundation

public struct DateUtils {
    public static let defaultDateTimeStamp: Int64 = -2209161600000
    public static func buildDateTimeStamp(_ str: String) -> Int64? {
        guard
                let ts = str.asUtcDate(format: "yyy-MM-dd'T'HH:mm:ss.SSS'Z'")?.toMillis,
                ts > defaultDateTimeStamp
                else {
            return nil
        }
        return ts
    }

    public static func buildDateTimeStr(_ ts: Int64?) -> String {
        Date
                .from(millis: ts ?? defaultDateTimeStamp)
                .toString(as: "yyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
}
