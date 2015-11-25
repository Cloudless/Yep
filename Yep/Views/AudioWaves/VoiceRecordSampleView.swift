//
//  VoiceRecordSampleView.swift
//  Yep
//
//  Created by nixzhu on 15/11/25.
//  Copyright © 2015年 Catch Inc. All rights reserved.
//

import UIKit

class VoiceRecordSampleView: UIView {

    var sampleValues: [CGFloat] = []

    lazy var sampleCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsetsZero
        layout.itemSize = CGSize(width: 2, height: 60)
        layout.scrollDirection = .Horizontal
        return layout
    }()

    lazy var sampleCollectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: self.sampleCollectionViewLayout)
        view.dataSource = self
        view.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        makeUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        sampleCollectionViewLayout.itemSize = CGSize(width: 2, height: sampleCollectionView.bounds.height)
    }

    func makeUI() {

        addSubview(sampleCollectionView)
        sampleCollectionView.translatesAutoresizingMaskIntoConstraints = false

        let views = [
            "sampleCollectionView": sampleCollectionView,
        ]

        let sampleCollectionViewConstraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[sampleCollectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let sampleCollectionViewConstraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[sampleCollectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)

        NSLayoutConstraint.activateConstraints(sampleCollectionViewConstraintH)
        NSLayoutConstraint.activateConstraints(sampleCollectionViewConstraintV)
    }

    func appendSampleValue(value: CGFloat) {
        sampleValues.append(value)

        let indexPath = NSIndexPath(forItem: sampleValues.count - 1, inSection: 0)
        sampleCollectionView.insertItemsAtIndexPaths([indexPath])
    }
}

extension VoiceRecordSampleView: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleValues.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.lightGrayColor()
        return cell
    }
}
