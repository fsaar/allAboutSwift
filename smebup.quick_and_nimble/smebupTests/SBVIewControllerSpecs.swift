import Quick
import Nimble

@testable import smebup

class SBViewControllerTestRequestManager: SBRequestManager {
    var tflCameraListCalled = false
    override func tflCameraList(completionBlock:(([SBJamCamListEntry]?,error:NSError?) -> ())?) throws {
        tflCameraListCalled = true
    }

}

class SBViewControllerSpecs: QuickSpec {

    override func spec() {
        var controller : SBViewController!

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            controller =  storyboard.instantiateViewControllerWithIdentifier("SBViewController") as? SBViewController

        };
        it("should not be nil") {
            expect(controller).notTo(beNil())
        }
        
        it ("should call requestManagers tflCameralist initialising view") {
            let requestManager = SBViewControllerTestRequestManager()
            controller.requestManager = requestManager
            _ = controller.view
            expect(requestManager.tflCameraListCalled) == true
        }
        
        it ("should conform to collectionViewDelegate") {
            let delegate = controller as UICollectionViewDelegate
            expect(delegate).notTo(beNil())
        }
        
        it ("should conform to collectionViewDataSource") {
            let datasource = controller as UICollectionViewDataSource
            expect(datasource).notTo(beNil())
            
        }
        
        context("when dealing with the collectionViewDelegate") {
            pending("should return a constant cellsize when calling collectionView:layout:sizeForItemAtIndexPath:") {
            }
            
        }
        
        context("when dealing with the collectionViewDataSource") {
            pending("should return number of cameralistentries when calling collectionView:numberOfItemsInSection:") {
                
            }
            
            pending("should configure a cell with the correct model") {
                
            }
            
        }

    }
    
    
}
