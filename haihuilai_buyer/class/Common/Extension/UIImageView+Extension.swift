//
//  UIImageView+Extension.swift
//  haihuilai_buyer
//
//  Created by jonker on 16/12/13.
//  Copyright © 2016年 haihuilai. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        image = UIImage.init(named: imageName)
    }

}
