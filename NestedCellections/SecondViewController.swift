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


    // Timer ラベル
    weak var timer: Timer!          //追加
    var startTime = Date()

    var minute: UILabel!
    var seconds: UILabel!
    var miniSeconds: UILabel!



    // Play ボタン
    var playStartButton: UIButton!
    var playStopButton: UIButton!

    // Upload ボタン
    var uploadButton: UIButton!

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
        // 停止中のボタン＆ラベル in ViewDidload
        // ============================

        recordingButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 50, width: 250, height: 250))

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
        // 録音中のボタン＆ラベル in ViewDidload
        // =============================


        redRecordingButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: (view.frame.width - 250)/2, y: view.frame.height - 250 - 50, width: 250, height: 250))

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

        // ============================
        // Playボタン in ViewDidload
        // =============================

        playStartButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: 10, y: 40, width: 150, height: 60))

            uiButton.setImage(#imageLiteral(resourceName: "playStartButton"), for: .normal)
            uiButton.contentMode = .scaleToFill
            uiButton.addTarget(self, action: #selector(play), for: .touchUpInside)
            return uiButton
        }()

        playStopButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: 10, y: 40, width: 150, height: 60))

            uiButton.setImage(#imageLiteral(resourceName: "playStopButton"), for: .normal)
            uiButton.contentMode = .scaleToFill
            uiButton.addTarget(self, action: #selector(play), for: .touchUpInside)
            return uiButton
        }()


        // ============================
        // Uploadボタン in ViewDidload
        // =============================

        uploadButton = {
            let uiButton: UIButton = UIButton(frame: CGRect(x: view.frame.width - 150 - 10, y: 40, width: 150, height: 60))

            uiButton.setImage(#imageLiteral(resourceName: "uploadButton"), for: .normal)
            uiButton.contentMode = .scaleToFill
            uiButton.addTarget(self, action: #selector(onClickMyButton), for: .touchUpInside)
            return uiButton
        }()


        view.addSubview(recordingButton)
        view.addSubview(stopBlueImage)



    }


    override func viewDidLayoutSubviews() {


    }




    // Alert Func
    @objc func logoutAlertController() {

        let alertController = UIAlertController(title: "Upload this voice file?", message: "If agree our plivacy policy and upload this voice file to our server, please choose Upload button", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Cancel", style: .destructive) { (action: UIAlertAction!) in
            print("Cancel")

        }


        let cancelAction = UIAlertAction(title: "Uploard", style: .default, handler: { (action: UIAlertAction!) in
            print("Upload")
        })

        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
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
            playStartButton.isEnabled = false

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

            playStartButton.isEnabled = true

            // 録音中ボタンを削除して、録音ボタンを表示する
            redRecordingButton.removeFromSuperview()
            view.addSubview(recordingButton)

            // 録音中イメージを削除して、録音イメージを表示する
            recordingRedImage.removeFromSuperview()
            view.addSubview(stopBlueImage)

            // playボタンを表示する
            view.addSubview(playStartButton)


            // upLoadボタンを表示する
            view.addSubview(uploadButton)

        }
    }


    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }


    // ========= Play Button Function ===========
    @objc func play(){
           if !isPlaying {

               audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
               audioPlayer.delegate = self
               audioPlayer.play()

               isPlaying = true

            playStartButton.removeFromSuperview()
            view.addSubview(playStopButton)

               recordingButton.isEnabled = false

           }else{

               audioPlayer.stop()
               isPlaying = false

            playStopButton.removeFromSuperview()
            view.addSubview(playStartButton)

               recordingButton.isEnabled = true

           }
       }


    //    ここから
    @objc func timerCounter() {

        let currentTime = Date().timeIntervalSince(startTime)
        let minutelo = (Int)(fmod((currentTime/60), 60))
        let second = (Int)(fmod(currentTime, 60))

        let msec = (Int)((currentTime - floor(currentTime))*100)

        let sMinute = String(format:"%02d", minutelo)
        let sSecond = String(format:"%02d", second)
        let sMsec = String(format:"%02d", msec)

        minute.text = sMinute
        seconds.text = sSecond
        miniSeconds.text = sMsec

    }



    // convert m4a to WAV
    func convertAudio(_ url: URL, outputURL: URL) {
        var error : OSStatus = noErr
        var destinationFile: ExtAudioFileRef? = nil
        var sourceFile : ExtAudioFileRef? = nil

        var srcFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()
        var dstFormat : AudioStreamBasicDescription = AudioStreamBasicDescription()

        ExtAudioFileOpenURL(url as CFURL, &sourceFile)

        var thePropertySize: UInt32 = UInt32(MemoryLayout.stride(ofValue: srcFormat))

        ExtAudioFileGetProperty(sourceFile!,
                                kExtAudioFileProperty_FileDataFormat,
                                &thePropertySize, &srcFormat)

        dstFormat.mSampleRate = 44100  //Set sample rate
        dstFormat.mFormatID = kAudioFormatLinearPCM
        dstFormat.mChannelsPerFrame = 1
        dstFormat.mBitsPerChannel = 16
        dstFormat.mBytesPerPacket = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mBytesPerFrame = 2 * dstFormat.mChannelsPerFrame
        dstFormat.mFramesPerPacket = 1
        dstFormat.mFormatFlags = kLinearPCMFormatFlagIsPacked |
        kAudioFormatFlagIsSignedInteger

        // Create destination file
        error = ExtAudioFileCreateWithURL(
            outputURL as CFURL,
            kAudioFileWAVEType,
            &dstFormat,
            nil,
            AudioFileFlags.eraseFile.rawValue,
            &destinationFile)
        print("Error 1 in convertAudio: \(error.description)")

        error = ExtAudioFileSetProperty(sourceFile!,
                                        kExtAudioFileProperty_ClientDataFormat,
                                        thePropertySize,
                                        &dstFormat)
        print("Error 2 in convertAudio: \(error.description)")

        error = ExtAudioFileSetProperty(destinationFile!,
                                        kExtAudioFileProperty_ClientDataFormat,
                                        thePropertySize,
                                        &dstFormat)
        print("Error 3 in convertAudio: \(error.description)")

        let bufferByteSize : UInt32 = 32768
        var srcBuffer = [UInt8](repeating: 0, count: 32768)
        var sourceFrameOffset : ULONG = 0

        while(true){
            var fillBufList = AudioBufferList(
                mNumberBuffers: 1,
                mBuffers: AudioBuffer(
                    mNumberChannels: 2,
                    mDataByteSize: UInt32(srcBuffer.count),
                    mData: &srcBuffer
                )
            )
            var numFrames : UInt32 = 0

            if(dstFormat.mBytesPerFrame > 0){
                numFrames = bufferByteSize / dstFormat.mBytesPerFrame
            }

            error = ExtAudioFileRead(sourceFile!, &numFrames, &fillBufList)
            print("Error 4 in convertAudio: \(error.description)")

            if(numFrames == 0){
                error = noErr;
                break;
            }

            sourceFrameOffset += numFrames
            error = ExtAudioFileWrite(destinationFile!, numFrames, &fillBufList)
            print("Error 5 in convertAudio: \(error.description)")
        }

        error = ExtAudioFileDispose(destinationFile!)
        print("Error 6 in convertAudio: \(error.description)")
        error = ExtAudioFileDispose(sourceFile!)
        print("Error 7 in convertAudio: \(error.description)")
    }



     /*
     ボタンイベント. 画面遷移。
     */
    @objc func onClickMyButton(sender: UIButton){

        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = inputNameGenderBMI()

        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = .coverVertical

        // Viewの移動する.
        present(mySecondViewController, animated: false, completion: nil)
    }


}



