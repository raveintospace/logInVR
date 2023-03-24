//
//  UILabel+Extensions.swift
//  LogInVR
//
//  Created by Uri on 24/3/23.
//

import Foundation
import UIKit

extension UILabel {
    func standardSetup() {
        layer.cornerRadius = 5.0
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        textColor = .black
    }
}
