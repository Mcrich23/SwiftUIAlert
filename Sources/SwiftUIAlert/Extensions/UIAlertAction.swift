//
//  UIAlertAction.swift
//  
//
//  Created by Morris Richman on 4/8/23.
//

import Foundation

#if canImport(UIKit)
import UIKit

extension UIAlertAction {
    public static func ok(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok button in alert"), style: .default, handler: handler)
    }
}
#endif
