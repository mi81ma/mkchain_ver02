//
//  ViewController.swift
//  mkchain
//
//  Created by masato on 19/10/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    var backgroundImageView: UIImageView = {

        let image = UIImageView(image: #imageLiteral(resourceName: "successRecording"))
        return image
    }()




    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor.darkGray
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))



        var imageButton: UIButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 300)/2, y: view.frame.height - 80 - 50, width: 300, height: 80))

            uiButton.setImage(#imageLiteral(resourceName: "ViewHistoryButton"), for: .normal)
            uiButton.contentMode = .scaleToFill
            uiButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
            return uiButton
        }()



          view.addSubview(imageButton)

    }



    override func viewDidLayoutSubviews() {


    }

            /*
         ボタンイベント.
         */

        @objc func onClickMyButton(sender: UIButton){

            // 遷移するViewを定義する.
                      let mySecondViewController: UIViewController = HistoryViewController()

                      // アニメーションを設定する.
                      mySecondViewController.modalTransitionStyle = .coverVertical

                      // Viewの移動する.
                      present(mySecondViewController, animated: false, completion: nil)
                  }


}




