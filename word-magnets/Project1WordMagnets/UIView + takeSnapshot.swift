//
//  UIView + takeSnapshot.swift
//  Counter
//
//  Created by Student on 2/25/18.
//  Copyright © 2018 tony. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func takeSnapshot() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
