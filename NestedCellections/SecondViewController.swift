//
//  ViewController.swift
//  mkchain
//
//  Created by masato on 19/10/2019.
//  Copyright © 2019 masato. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    // ラベルを作成する
    var recordingLabel: UILabel!

    var recordingButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var isRecording = false
    var isPlaying = false

    var backgroundImageView: UIImageView = {

        let image = UIImageView(image: #imageLiteral(resourceName: "startRecording"))
        return image
    }()




    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = UIColor.darkGray
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: view.frame.height))



        recordingButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 85, width: 250, height: 250))

            uiButton.setImage(#imageLiteral(resourceName: "microPhoneBlue"), for: .normal)
            uiButton.contentMode = .scaleToFill
//            uiButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
            uiButton.addTarget(self, action: #selector(onClickRecord), for: .touchUpInside)
            return uiButton
        }()


        recordingLabel = {

            let label = UILabel(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 85, width: 250, height: 250))

            label.text = "not recording"

            return label

        }()




//        self.view.addSubview(backImage)
        view.addSubview(recordingButton)

          view.addSubview(recordingButton)
        view.addSubview(recordingLabel)

    }



    override func viewDidLayoutSubviews() {


    }

        /*
     ボタンイベント.
     */

//    @objc func onClickMyButton(sender: UIButton){
//
//        // 遷移するViewを定義する.
//        let mySecondViewController: UIViewController = ThirdViewController()
//
//        // アニメーションを設定する.
//        mySecondViewController.modalTransitionStyle = .coverVertical
//
//        // Viewの移動する.
//        present(mySecondViewController, animated: false, completion: nil)
//    }



//  ============= Audio ===============
    @objc func onClickRecord(){
        if !isRecording {

            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSession.Category.playAndRecord)
            try! session.setActive(true)

            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            isRecording = true

            recordingLabel.text = "Now Recording"
            recordingButton.setTitle("STOP", for: .normal)
//            playButton.isEnabled = false

        }else{

            audioRecorder.stop()
            isRecording = false

            recordingLabel.text = "Record Stopping"
            recordingButton.setTitle("RECORD", for: .normal)
//            playButton.isEnabled = true

        }
    }


    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }



}



