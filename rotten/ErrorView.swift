//
//  ErrorView.swift
//  rotten
//
//  Created by Niaz Jalal on 9/16/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    var imageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addSubview(self.imageView)
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func setLabelText(text: NSString) {
        self.label.text = text
    }
    
}
