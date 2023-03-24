//
//  UITextField+Extensions.swift
//  LogInVR
//
//  Created by Uri on 24/3/23.
//

import Foundation
import UIKit

extension UITextField {
    func standardSetup(nameInField: String) {
        layer.cornerRadius = 5.0
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        autocapitalizationType = .none
        autocorrectionType = .no
        attributedPlaceholder = NSAttributedString(string: nameInField,
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
