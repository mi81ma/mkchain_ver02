//
//  PowerLevel.swift
//  mkchain
//
//  Created by masato on 21/10/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit


class FileListView: UIViewController {

    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        return tableView
    }()


    lazy var statusBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()


    lazy var popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8327578902, green: 0.9971920848, blue: 1, alpha: 1)
        return view
    }()


    lazy var recordButtonBlue: UIButton = {
        let button: UIButton = UIButton()
        button.constrainWidth(constant: 120)
        button.constrainHeight(constant: 120)

        button.setImage(#imageLiteral(resourceName: "microPhoneBlue"), for: .normal)

        button.addTarget(self, action: #selector(recording), for: .touchUpInside)
        return button
    }()


        lazy var recordingButtonRed: UIButton = {
            let button: UIButton = UIButton()
            button.constrainWidth(constant: 120)
            button.constrainHeight(constant: 120)

//            button.setImage(#imageLiteral(resourceName: "microPhoneRed"), for: .normal)

            button.addTarget(self, action: #selector(stopRecording), for: .touchUpInside)

            return button
        }()




    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = .systemGreen

        view.addSubview(popUpView)
        popUpView.addSubview(recordButtonBlue)

        view.addSubview(statusBarView)
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()


        // Recording Button
        popUpView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 150))

        recordButtonBlue.centerInSuperview()


        // Status Bar
        statusBarView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 150, right: 0), size: .init(width: view.frame.width, height: 80))

    }

    @objc func recording() {

        // 画像
        let image = UIImage(named: "microPhoneRed") // 回したい画像
        let imageView = UIImageView(image: image)
        imageView.constrainHeight(constant: 120)
        imageView.constrainWidth(constant: 120)
        recordingButtonRed.addSubview(imageView)
        imageView.centerInSuperview()

        // アニメーション
        let rollingAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rollingAnimation.fromValue = 0
        rollingAnimation.toValue = CGFloat.pi * 2.0
        rollingAnimation.duration = 2.0 // 周期２秒
        rollingAnimation.repeatDuration = CFTimeInterval.infinity // 無限に
        imageView.layer.add(rollingAnimation, forKey: "rollingImage") // アニメーションを

        recordButtonBlue.removeFromSuperview()
        popUpView.addSubview(recordingButtonRed)
        recordingButtonRed.centerInSuperview()

        popUpView.backgroundColor = #colorLiteral(red: 1, green: 0.4816293716, blue: 0.8635653257, alpha: 1)

    }


    @objc func stopRecording() {
        recordingButtonRed.removeFromSuperview()
        popUpView.addSubview(recordButtonBlue)

        popUpView.backgroundColor = #colorLiteral(red: 0.8327578902, green: 0.9971920848, blue: 1, alpha: 1)
    }

}
