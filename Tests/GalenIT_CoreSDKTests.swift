import XCTest
import GalenitCoreKit

class DateExt_Tests: XCTestCase {

    override func setUpWithError() throws {
      
    }

    override func tearDownWithError() throws {
        
    }

    func testDate_UserFriendlyFormatting_justNow() throws {
        //setup
        let ts = Date().toMillis
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case .justNow: break
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    func testDate_UserFriendlyFormatting_minutes() throws {
        //setup
        let ts = Date().toMillis - 1000*60*2
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case let .someMinutesAgo(val):
            XCTAssertTrue(val < 3)
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    func test_Date_UserFriendlyFormatting_hours() throws {
        //setup
        let ts = Date().toMillis - 1000*60*60*2
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case let .someHoursAgo(val):
            XCTAssertTrue(val < 3)
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    
    func test_Date_UserFriendlyFormatting_yesterday() throws {
        //setup
        let ts = Date().toMillis - 1000*60*60*24
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case .yesterday: break
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    func test_Date_UserFriendlyFormatting_week() throws {
        //setup
        let ts = Date().toMillis - 1000*60*60*48
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case let .currentWeekLocalized(val):
            print(val)
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    func test_Date_UserFriendlyFormatting_thisYear() throws {
        //setup
        let ts = Date().toMillis - 1000*60*60*24*7
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case let .currentYearLocalized(val):
            print(val)
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }
    
    func test_Date_UserFriendlyFormatting_moreThanYear() throws {
        //setup
        let ts = Date().toMillis - 1000*60*60*24*366
        
        //action
        let dateFormat = ts.date.userFriendlyFormatted()
        
        //assert
        switch dateFormat {
        case let .moreThanYearLocalized(val):
            print(val)
        default:
            XCTFail("\(dateFormat) is incorrect")
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
