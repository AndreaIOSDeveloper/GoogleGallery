//
//  NibView.swift
//  GoogleGallery
//
//  Created by Andrea Di Francia on 01/06/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class NibView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        //swiftlint:disable:next force_cast
        translatesAutoresizingMaskIntoConstraints = false
        let view = type(of: self).nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.fill(view: self, insets: .zero, useSafeArea: false)
        awakeFromNib()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
}
