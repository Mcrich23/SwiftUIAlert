//
//  SwiftUIAlert.swift
//  
//
//  Created by Morris Richman on 3/28/22.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)// || os(macOS)
import SwiftUIX

public struct SwiftUIAlert {
    public static func show(imageView: UIImageView? = nil, title: String, message: String, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let presentingAlert = UIAlertController(title: NSLocalizedString(title, comment: "Title in SwiftUIAlert"), message: NSLocalizedString(message, comment: "Message in SwiftUIAlert"), preferredStyle: preferredStyle)
        if let imageView {
            presentingAlert.view.addSubview(imageView)
        }
        for action in actions {
            presentingAlert.addAction(action)
        }
        guard var topVC = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        topVC.present(presentingAlert, animated: true, completion: nil)
    }
    public static func textfieldShow(imageView: UIImageView? = nil, title: String, message: String, preferredStyle: UIAlertController.Style, textfield: AlertTextfield, actions: [UIAlertAction]) {
        let presentingAlert = UIAlertController(title: NSLocalizedString(title, comment: "Title in SwiftUI TextfieldAlert"), message: NSLocalizedString(message, comment: "Message in SwiftUI TextfieldAlert"), preferredStyle: preferredStyle)
        if let imageView {
            presentingAlert.view.addSubview(imageView)
        }
        presentingAlert.addTextField { tf in
            tf.autocorrectionType = textfield.autocorrectionType
            tf.placeholder = NSLocalizedString(textfield.placeholder, comment: "")
            tf.text = textfield.text
            tf.clearButtonMode = textfield.clearButtonMode
            //                tf.clearsOnBeginEditing = textfield.clearsOnBeginEditing
            tf.enablesReturnKeyAutomatically = textfield.enablesReturnKeyAutomatically
            tf.autocapitalizationType = textfield.autocapitalization
            tf.returnKeyType = textfield.returnKeyType
            tf.keyboardType = textfield.keyboardType
            tf.keyboardAppearance = textfield.keyboardAppearance
            switch textfield.isSecureTextEntry {
            case .yes(let passwordRules):
                tf.isSecureTextEntry = true
                tf.passwordRules = passwordRules
            case .no:
                tf .isSecureTextEntry = false
            }
        }
        func setText() {
            if let textField = presentingAlert.textFields?.first, let text = textField.text {
                //                print("Code = \(text)")
                textfield.text = text
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                setText()
            }
        }
        setText()
        for action in actions {
            presentingAlert.addAction(action)
        }
        guard var topVC = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        topVC.present(presentingAlert, animated: true, completion: nil)
    }
    public static func dismissAnyAlertIfPresent() {
        guard var topVC = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first?.rootViewController else {
            return
        }
        // iterate til we find the topmost presented view controller
        // if you don't you'll get an error since you can't present 2 vcs from the same level
        while let presentedVC = topVC.presentedViewController {
            topVC = presentedVC
        }
        if topVC.isKind(of: UIAlertController.self) {
            topVC.dismiss(animated: false, completion: nil)
        }
    }
}
#endif
