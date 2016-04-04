//
//  SBCameraListCell.swift
//  smebup
//
//  Created by Frank Saar on 17/02/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import UIKit

public class SBCameraListCell : UICollectionViewCell {
    @IBOutlet private var cameraView : UIImageView!
    @IBOutlet private var descriptionLabel : UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.descriptionLabel.textColor = UIColor.blackColor()
        self.descriptionLabel.backgroundColor = self.contentView.backgroundColor
        self.descriptionLabel.opaque =  true
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.cameraView.image = nil
        self.descriptionLabel.text = nil
    }
    
    public func configure(cameraListEntry : SBJamCamListEntry) {
        self.descriptionLabel.text = cameraListEntry.description
        
        if let urlString = cameraListEntry.imageURL {
            SBImageCache.sharedCache.image(urlString) { [urlString] image, imageURLString in
                if urlString == imageURLString {
                    self.cameraView.image = image
                }
            }
        }
  
    }
}