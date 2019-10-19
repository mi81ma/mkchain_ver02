//
//  MovieGroupCell.swift
//  NestedCellections
//
//  Created by masato on 11/5/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class  MovieGroupCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie Section"
        label.font = UIFont.boldSystemFont(ofSize: 17)

        label.translatesAutoresizingMaskIntoConstraints = false

        return label

    }()

    let moviesHorizontalController = MoviesHorizontalController(collectionViewLayout: UICollectionViewFlowLayout())

    override init(frame: CGRect) {
        super.init(frame: frame)

        guard let controllerView = moviesHorizontalController.view else { return }
        let stackView = UIStackView(arrangedSubviews: [titleLabel, controllerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 40)

        addSubview(stackView)
        stackView.axis = .vertical

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])


//        self.addSubview(titleLabel)

//        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
