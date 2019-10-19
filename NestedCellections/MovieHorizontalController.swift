//
//  MovieHorizontalController.swift
//  NestedCellections
//
//  Created by masato on 11/5/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class MoviesHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    private let cellId = "cellId"
    private let prototypeItems: CGFloat = 3
    private let lineSpacing: CGFloat = 10



    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(MovieRowCell.self, forCellWithReuseIdentifier: cellId)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            let width = (view.frame.width - 2 * lineSpacing) / prototypeItems

            layout.itemSize = .init(width: width, height: view.frame.height)
        }

    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieRowCell

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 2 * lineSpacing) / prototypeItems
//        print("width: \(width)")
//
//        return .init(width: width - 12, height: view.frame.height)
//
//    }

//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: layout)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
