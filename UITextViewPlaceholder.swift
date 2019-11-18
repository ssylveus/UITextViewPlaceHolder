//
//  UITextViewPlaceholder.swift
//
//  Created by Steeven Sylveus on 4/23/19.
//  Copyright © 2019 Steeven Sylveus. All rights reserved.
//

import UIKit

var textFieldPlaceHolderText = ""
private var placeholderTextView: UITextView = UITextView(frame: CGRect.zero)

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
        if !subviews.contains(placeholderTextView) {
            // placeholderTextView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.width, height: 70))
            placeholderTextView.isUserInteractionEnabled = false
            placeholderTextView.isSelectable = false
            placeholderTextView.text = textFieldPlaceHolderText
            placeholderTextView.textColor = .lightGray
            placeholderTextView.font = font
            placeholderTextView.frame = self.bounds
            placeholderTextView.backgroundColor = UIColor.clear
            addSubview(placeholderTextView)
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
        placeholderTextView.isHidden = text.count > 0
    }
}
