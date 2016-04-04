import Quick
import Nimble

@testable import smebup

class SBRequestManagerTask : NSURLSessionDataTask {
    
    override func  resume() {
        
    }
}


class SBRequestManagerTestSession : NSURLSession {
    var dataTaskWithURLCalled = false
    var dataTaskURL : NSURL?
    var callblack : ((completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> Void)?
    override func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        self.dataTaskWithURLCalled = true
        self.dataTaskURL = url
        callblack?(completionHandler: completionHandler)
        return SBRequestManagerTask()
    }
}

class SBRequestManagerSpecs: QuickSpec {

    override func spec() {
        
        it ("should not be nil") {
            let manager = SBRequestManager.sharedManager
            expect(manager).notTo(beNil())
        }
        
        it ("should always return the same instance") {
            let manager1 = SBRequestManager.sharedManager
            let manager2 = SBRequestManager.sharedManager
            expect(manager1) === manager2
        }
        
        context("when calling tflCameraList") {
            var manager : SBRequestManager!
            var session  : SBRequestManagerTestSession!
            var validData : NSData?
            
            beforeEach() {
                session = SBRequestManagerTestSession()
                manager = SBRequestManager(session: session)
                let bundle = NSBundle(forClass: self.dynamicType)
                let url = bundle.URLForResource("camerList", withExtension: "json")
                validData = NSData(contentsOfURL: url!)

            };
            
            
            it("should use correct URL") {
                try! manager.tflCameraList( nil)
                let expectation = "https://api.tfl.gov.uk/Place/Type/jamcam"
                expect(session.dataTaskURL!.absoluteString.hasPrefix(expectation)) == true
            }
            
            it("should have an app id") {
                try! manager.tflCameraList( nil)
                expect(session.dataTaskURL!.absoluteString.rangeOfString("app_id=")).notTo(beNil())
            }
            
            it("should have an app key") {
                try! manager.tflCameraList( nil)
                expect(session.dataTaskURL!.absoluteString.rangeOfString("app_key=")).notTo(beNil())
                
            }

            
            it("should handle bogus data gracefully (NSData data)") {
                session.callblack = { completionHandler in
                    completionHandler(NSData(),nil,nil)
                }
                var completionBlockCalled = false
                try! manager.tflCameraList() { list,error in
                    completionBlockCalled = true
                }
                expect(completionBlockCalled).toEventually(beTrue())
            }

            it("should handle bogus data gracefully (nil data)") {
                session.callblack = { completionHandler in
                    completionHandler(nil,nil,nil)
                }
                var completionBlockCalled = false
                try! manager.tflCameraList() { list,error in
                    completionBlockCalled = true
                }
                expect(completionBlockCalled).toEventually(beTrue())
            }

            it("should return valid object with correct data") {
                
                session.callblack = { completionHandler in
                    completionHandler(validData,nil,nil)
                }
                var completionBlockCalled = false
                try! manager.tflCameraList() { list,error in
                    expect(list).notTo(beNil())
                    completionBlockCalled = true
                }
                expect(completionBlockCalled).toEventually(beTrue())
                
            }
            
            it("should call back on main thread") {
                session.callblack = { completionHandler in
                    completionHandler(validData,nil,nil)
                }
                var completionBlockCalled = false
                try! manager.tflCameraList() { list,error in
                    expect(NSThread.isMainThread()) == true
                    completionBlockCalled = true
                }
                expect(completionBlockCalled).toEventually(beTrue())

            }
            
        }
        
        
        context("when calling tflDataWithURL") {
            var manager : SBRequestManager!
            var session  : SBRequestManagerTestSession!
            var validData : NSData?
            
            beforeEach() {
                session = SBRequestManagerTestSession()
                manager = SBRequestManager(session: session)
                let bundle = NSBundle(forClass: self.dynamicType)
                let url = bundle.URLForResource("camerList", withExtension: "json")
                validData = NSData(contentsOfURL: url!)
                
            };
            
            it("should NOT have an app id nor app key") {
                let expectation = "https://api.tfl.gov.uk/Place/Type/jamcam"
                let url = NSURL(string: expectation)
                try! manager.tflDataWithURL(url!) { _,_ in }
                let usedURLString = session.dataTaskURL!.absoluteString
                expect(usedURLString.rangeOfString("app_id=")).to(beNil())
                expect(usedURLString.rangeOfString("app_key=")).to(beNil())
            }

            it("should use correct URL") {
                let expectation = "https://api.tfl.gov.uk/Place/Type/jamcam"
                let url = NSURL(string: expectation)
                try! manager.tflDataWithURL(url!) { _,_ in }
                let usedURLString = session.dataTaskURL!.absoluteString
                expect(usedURLString) == expectation
            }
            
            
            it("should call completionBlock") {
                session.callblack = { completionHandler in
                    completionHandler(validData,nil,nil)
                }
                let expectation = "https://api.tfl.gov.uk/Place/Type/jamcam"
                let url = NSURL(string: expectation)
                var completionBlockCalled = false
                try! manager.tflDataWithURL(url!) { data,error in
                    completionBlockCalled = true
                }
                expect(completionBlockCalled).toEventually(beTrue())

            }
            
        }

    }

}
