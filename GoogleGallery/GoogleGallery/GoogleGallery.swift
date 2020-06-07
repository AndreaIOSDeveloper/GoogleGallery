//
//  GoogleGallery.swift
//  GoogleGallery
//
//  Created by Andrea Di Francia on 01/06/2020.
//  Copyright © 2020 Andrea Di Francia. All rights reserved.
//

import Foundation
import UIKit

public protocol GoogleGalleryDelegate: class {
    func googleGallery(collectionView: UICollectionView, didSelect image: UIImage)
}

@IBDesignable public class GoogleGallery: UIView {
    // Private Variable
    private var externalStack: UIStackView = {
        let stack = UIStackView()
        stack.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    
    private var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var subDetailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    weak var delegate: GoogleGalleryDelegate?
    
    lazy private var collectionGalleryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width/2, height: 200), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.cellIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return collectionView
    }()
    private var isScrollGalleryToLeft: Bool = false
    
    // Public Variable
    lazy public var images: [UIImage] = []
    lazy public var sizeItemGallery: CGSize = .zero
    lazy public var minimumItemLineSpacing: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("init2")
        setStack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init2")
        setStack()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")

        setStack()
    }
    
    public func configure (title: String, detail: String, subDetail: String) {
        print("configure")
        titleLabel.text = title
        detailLabel.text = detail
        subDetailLabel.text = subDetail
    }
    
    public func setCollection(with backgroundColor: UIColor) {
        collectionGalleryView.backgroundColor = backgroundColor
    }
    
    /// This function  `setStacks`.
    ///
    /// ```
    /// setStacks(with externalStackSpacing: CGFloat, containerStackSpacing: CGFloat)
    /// ```
    ///
    /// - Warning: The returned string is not localized.
    /// - Parameter subject: The subject to be welcomed.
    /// - Returns: A hello string to the `subject`.
    public func setStacks(with externalStackSpacing: CGFloat = 0, containerStackSpacing: CGFloat = 0) {
        externalStack.spacing = externalStackSpacing
        containerStack.spacing = containerStackSpacing
    }
    
    /// This function reload data inside a collectionView `reloadData`.
    ///
    public func reloadData() {
        collectionGalleryView.reloadData()
    }
    
    private func setStack() {
        print("setStack")
        self.addSubview(externalStack)
        externalStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        externalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        externalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        externalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(detailLabel)
        containerStack.addArrangedSubview(subDetailLabel)
        externalStack.addArrangedSubview(containerStack)
        externalStack.addArrangedSubview(collectionGalleryView)
    }
}

extension GoogleGallery: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.cellIdentifier, for: indexPath) as? GalleryCell
          
        cell?.configure(image: images[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.googleGallery(collectionView: collectionView, didSelect: images[indexPath.item])
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionGalleryView.contentOffset, size: self.collectionGalleryView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionGalleryView.indexPathForItem(at: visiblePoint) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3) {
                    if visibleIndexPath.row > 0 && self.isScrollGalleryToLeft == false {
                        self.containerStack.isHidden = true
                        self.isScrollGalleryToLeft = true
                    } else if visibleIndexPath.row < 2 && self.isScrollGalleryToLeft == true {
                        self.isScrollGalleryToLeft = false
                        self.containerStack.isHidden = false
                    }
                }
            }
        }
    }
}

extension GoogleGallery: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeItemGallery
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemLineSpacing
    }
}
