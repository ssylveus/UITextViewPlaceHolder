//
//  UITextViewPlaceholder.swift
//
//  Created by Steeven Sylveus on 4/23/19.
//  Copyright © 2019 Steeven Sylveus. All rights reserved.
//

import UIKit

var textFieldPlaceHolderText = ""
var textViewTextField: UITextField = UITextField(frame: CGRect.zero)

extension UITextView: UITextViewDelegate {
    public var placeholder: String? {
        get {
            return textFieldPlaceHolderText
        }
        set {
            textFieldPlaceHolderText = newValue ?? ""
            addPlaceHolder()
            updatePlaceHolder()
            addObservers()
        }
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textViewDidChange),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBeginEditing),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEndEditing),
                                               name: UITextView.textDidEndEditingNotification,
                                               object: nil)
    }

    private func addPlaceHolder() {
        if !subviews.contains(textViewTextField) {
            textViewTextField.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 40)

            textViewTextField.isUserInteractionEnabled = false
            textViewTextField.placeholder = "  \(textFieldPlaceHolderText)"
            textViewTextField.borderStyle = .none
            textViewTextField.font = font
            addSubview(textViewTextField)
        }
    }

    @objc
    func didBeginEditing() {
        updatePlaceHolder()
    }

    @objc
    func didEndEditing() {
        updatePlaceHolder()
    }

    @objc
    func textViewDidChange() {
        updatePlaceHolder()
    }

    private func updatePlaceHolder() {
        textViewTextField.isHidden = text.count > 0
    }
}
