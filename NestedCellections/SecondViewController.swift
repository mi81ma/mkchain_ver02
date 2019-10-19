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
    var redRecordingButton: UIButton!

    var stopBlueImage: UIImageView!
    var recordingRedImage: UIImageView!

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


        view.backgroundColor = UIColor.white



        // ============================
        // 停止中のボタン＆ラベル
        // ============================

        recordingButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 85, width: 250, height: 250))

            uiButton.setImage(#imageLiteral(resourceName: "microPhoneBlue"), for: .normal)
            uiButton.contentMode = .scaleToFill

            uiButton.addTarget(self, action: #selector(onClickRecord), for: .touchUpInside)
            return uiButton
        }()


        stopBlueImage = {
            let imageView:UIImageView = UIImageView(frame: CGRect(x: (view.frame.width - 260)/2, y: (view.frame.height - 260)/2 - 100, width: 260, height: 260))
            imageView.image = #imageLiteral(resourceName: "recordingBlue")

            return imageView
        }()


        // ============================
        // 録音中のボタン＆ラベル
        // =============================


        redRecordingButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 85, width: 250, height: 250))

            uiButton.setImage(#imageLiteral(resourceName: "microPhoneRed"), for: .normal)
            uiButton.contentMode = .scaleToFill
            uiButton.addTarget(self, action: #selector(onClickRecord), for: .touchUpInside)
            return uiButton
        }()


        recordingRedImage = {
            let imageView:UIImageView = UIImageView(frame: CGRect(x: (view.frame.width - 260)/2, y: (view.frame.height - 260)/2 - 100, width: 260, height: 260))
            imageView.image = #imageLiteral(resourceName: "recordingRed")

            return imageView
        }()


        view.addSubview(recordingButton)

        view.addSubview(recordingButton)
        view.addSubview(stopBlueImage)

    }



    override func viewDidLayoutSubviews() {


    }




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

            // "録音中"の状態
//            recordingLabel.text = "Now Recording"
//            recordingButton.setTitle("STOP", for: .normal)
//            playButton.isEnabled = false

            // 録音ボタンを削除して、録音中ボタンを表示する
            recordingButton.removeFromSuperview()
            view.addSubview(redRecordingButton)

            // 録音イメージを削除して、録音中イメージを表示する
            stopBlueImage.removeFromSuperview()
            view.addSubview(recordingRedImage)


        }else{

            // "録音中が停止している状態"

            audioRecorder.stop()
            isRecording = false

//            recordingLabel.text = "Record Stopping"
//            recordingButton.setTitle("RECORD", for: .normal)
//            playButton.isEnabled = true

            // 録音中ボタンを削除して、録音ボタンを表示する
            redRecordingButton.removeFromSuperview()
            view.addSubview(recordingButton)

            // 録音中イメージを削除して、録音イメージを表示する
            recordingRedImage.removeFromSuperview()
            view.addSubview(stopBlueImage)

        }
    }


    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }



}



