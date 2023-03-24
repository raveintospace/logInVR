//
//  UIImageView+Extensions.swift
//  LogInVR
//
//  Created by Uri on 24/3/23.
//

import Foundation
import UIKit

extension UIImageView {
    func standardSetup(systemName: String, color: UIColor) {
        image = UIImage(systemName: systemName)
        tintColor = color
    }
}
