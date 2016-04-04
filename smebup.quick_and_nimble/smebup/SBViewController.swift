//
//  ViewController.swift
//  smebup
//
//  Created by Frank Saar on 16/02/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import UIKit

enum SBViewControllerCollectionViewCellType {
    case ListCell
}


class SBViewController: UIViewController {
    @IBOutlet private var collectionView : UICollectionView!
    var requestManager = SBRequestManager.sharedManager
    private var cameraList : [SBJamCamListEntry] = [] {
        didSet {
            self.collectionView .reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = try? requestManager.tflCameraList() { [weak self] list,error in
            if let cameraList = list {
                self?.cameraList = cameraList
            }
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 414, height: 80)
    }


}

extension SBViewController : UICollectionViewDelegateFlowLayout {
    
}

extension SBViewController: UICollectionViewDelegate {
    
}

extension SBViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(SBCameraListCell), forIndexPath: indexPath)
        
        if let cell = cell as? SBCameraListCell {
            cell.configure(self.cameraList[indexPath.item])
        }
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cameraList.count
    }
}

