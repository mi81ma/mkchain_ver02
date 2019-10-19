//
//  MovieRowCell.swift
//  NestedCellections
//
//  Created by masato on 11/5/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class MovieRowCell: UICollectionViewCell {


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
