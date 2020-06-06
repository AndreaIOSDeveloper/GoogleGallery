//
//  UIView+.swift
//  GoogleGallery
//
//  Created by Andrea Di Francia on 01/06/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var spaceFromDeviceBottom: CGFloat {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
            else { return 0 }
        let convertedFrame = convert(bounds, to: window)
        return window.bounds.height - convertedFrame.maxY
    }
    
    func loadNib(_ nib: UINib? = nil) {
        let nib = nib ?? type(of: self).nib
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.insertSubview(view)
        }
    }
    
    public class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    public static var cellIdentifier: String {
        return String(describing: self)
    }
    
    func insertSubview(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let binding = ["view" : view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: .alignAllTop, metrics: nil, views: binding))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: .alignAllTop, metrics: nil, views: binding))
    }
    
    @available(iOS, introduced: 11.0)
    func fill(view: UIView, insets: UIEdgeInsets = .zero, useSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        let leading = self.leadingAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor, constant: insets.left)
        let bottom = self.bottomAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor, constant: -insets.bottom)
        let trailing = self.trailingAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor, constant: -insets.right)
        let top = self.topAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor, constant: insets.top)
        NSLayoutConstraint.activate([leading, bottom, trailing, top])
    }
    
}
