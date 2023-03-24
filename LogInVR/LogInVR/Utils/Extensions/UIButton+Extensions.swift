//
//  UIButton+Extensions.swift
//  LogInVR
//
//  Created by Uri on 24/3/23.
//

import Foundation
import UIKit

extension UIButton {
    func standardTextSetup(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.blue, for: .normal)
    }
    
    func standardImageSetup(systemName: String) {
        setImage(UIImage(systemName: systemName), for: .normal)
        tintColor = .blue
    }
}
