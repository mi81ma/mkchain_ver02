//
//  ViewController.swift
//  mkchain
//
//  Created by masato on 19/10/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backgroundImageView: UIImageView = {

        let image = UIImageView(image: #imageLiteral(resourceName: "background_img"))
        return image
    }()




    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor.darkGray
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))


//        var backImage: UIImageView = {
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//
//            imageView.image = #imageLiteral(resourceName: "background_img")
//
//            return imageView
//        }()


        var imageButton: UIButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: 17, y: 550, width: 220, height: 190))

            uiButton.setImage(#imageLiteral(resourceName: "recording1_3x"), for: .normal)
            uiButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
            return uiButton
        }()




//        self.view.addSubview(backImage)
        view.addSubview(imageButton)

//          view.addSubview(imageButton)

    }



    override func viewDidLayoutSubviews() {


    }

        /*
     ボタンイベント.
     */

    @objc func onClickMyButton(sender: UIButton){

        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()

        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = .coverVertical

        // Viewの移動する.
        present(mySecondViewController, animated: true, completion: nil)
    }

}

