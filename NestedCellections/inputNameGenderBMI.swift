//
//  inputNameGenderBMI.swift
//  mkchain
//
//  Created by masato on 20/10/2019.
//  Copyright © 2019 masato. All rights reserved.
//


import UIKit


class inputNameGenderBMI: UIViewController {



    // Basic Var
    var email_Input = ""
    var password_Input = ""

    var usernameLoad = ""
    var passwordLoad = ""

    var accountId = 0
    var userId = 0

    var sessionToken = ""


    // How much Count: WebSocket
    var i_count = 0

    // loginButtonPressed for Unit Test
    var count_loginButtonPressed = 0






    override func viewDidLoad() {
        super.viewDidLoad()


        // keyboard hide delegate
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self


        [backGroundImage, welcomeTitleLabel, heightTextField, weightTextField, heightLabel, weightLabel, ageLabel, ageTextField, uploadButton].forEach {
            view.addSubview($0)
        }

        backGroundImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(width: view.frame.width, height: view.frame.height))

    }


    //***************************************************
    //MARK:- UIView -
    //***************************************************

    // Background image
    lazy var backGroundImage: UIImageView = {
         let imageView = UIImageView(image: UIImage(named: "starsImage.png"))
        imageView.accessibilityIdentifier = "backGroundImage"
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()



    // Textlabel
    lazy var welcomeTitleLabel: UILabel = {

        let label = UILabel(frame: CGRect(x:view.frame.width / 2 - (300 / 2), y:(heightTextField.frame.minY - 30) / 2, width:300, height:30))

        label.text = "Please fulfill below data"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Arial", size: 22.0)
        label.font =  UIFont.systemFont(ofSize: 25.0, weight: UIFont.Weight.medium)
        label.textColor = UIColor.white
        label.accessibilityIdentifier = "welcomeTitleLabel"
        return label
    }()


    // Height Label & Textfield
    lazy var heightLabel: UILabel = {
        let emailLabel = UILabel(frame: CGRect(x:view.frame.width / 2 - (250 / 2), y:heightTextField.frame.minY - 30, width:250, height:30))

        emailLabel.text = " Height :"
        emailLabel.textColor = UIColor.white

        emailLabel.accessibilityIdentifier = "heightLabel"
        return emailLabel
    }()


    lazy var heightTextField: UITextField = {
        let view = UITextField(frame: CGRect(x:self.view.frame.width / 2 - (250 / 2), y:self.view.frame.height / 2 - 100 - 100, width:250, height:40))
        if view.text == "" { view.placeholder = " Height" }
        if usernameLoad != "" { view.text = usernameLoad }
        view.borderStyle = UITextField.BorderStyle.roundedRect
        view.keyboardType = UIKeyboardType.emailAddress
        view.autocapitalizationType = UITextAutocapitalizationType.none
        view.accessibilityIdentifier = "heightTextField"

        return view
    }()


    // Weight Label & Textfield
    lazy var weightLabel: UILabel = {
        let passwordLabel = UILabel(frame: CGRect(x:view.frame.width / 2 - (250 / 2), y:weightTextField.frame.minY - 30, width:250, height:30))

        passwordLabel.text = " Weight :"
        passwordLabel.textColor = UIColor.white


        passwordLabel.accessibilityIdentifier = "weightLabel"
        return passwordLabel
    }()


    lazy var weightTextField: UITextField = {
        let view = UITextField(frame: CGRect(x:self.view.frame.width / 2 - (250 / 2), y:self.view.frame.height / 2 - 100, width:250, height:40))
        view.tag = 1020

        // Password Placeholder
        if passwordLoad != "" { view.text = passwordLoad }
        if view.text == "" { view.placeholder = " Weight" }

        // Border Corner is Rounded
        view.borderStyle = UITextField.BorderStyle.roundedRect

        // 入力された文字を非表示モードにする.
        view.isSecureTextEntry = false

        view.accessibilityIdentifier = "weightTextField"
        return view
    }()


    // Age Label & Textfield
     lazy var ageLabel: UILabel = {
         let ageLabel = UILabel(frame: CGRect(x:view.frame.width / 2 - (250 / 2), y:ageTextField.frame.minY - 30, width:250, height:30))

         ageLabel.text = " Age :"
         ageLabel.textColor = UIColor.white

         ageLabel.accessibilityIdentifier = "ageLabel"
         return ageLabel
     }()


     lazy var ageTextField: UITextField = {
         let view = UITextField(frame: CGRect(x:self.view.frame.width / 2 - (250 / 2), y:self.view.frame.height / 2, width:250, height:40))
         view.tag = 1020

         // Password Placeholder
         if passwordLoad != "" { view.text = passwordLoad }
         if view.text == "" { view.placeholder = " Age" }

         // Border Corner is Rounded
         view.borderStyle = UITextField.BorderStyle.roundedRect

         // 入力された文字を非表示モードにする.
         view.isSecureTextEntry = false

         view.accessibilityIdentifier = "ageTextField"
         return view
     }()



    // Login Button
    lazy var uploadButton: UIButton = {
        let loginButton = UIButton(frame: CGRect(x:self.view.frame.width / 2 - (200 / 2),  y:self.view.frame.height  - 150, width:200, height:40))
        view.tag = 1030

        loginButton.layer.cornerRadius = 5.0
        loginButton.backgroundColor =  UIColor(red: 0, green: 0.8213806748, blue: 0.4752416015, alpha: 1)
        loginButton.setTitle("Upload", for: .normal)
        loginButton.setBackgroundColor(color:  UIColor(red: 0, green: 0.4660990834, blue: 0.2602835298, alpha: 1), forState: .highlighted)

        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)

        loginButton.accessibilityIdentifier = "uploadButton"

        var count = 0

        return loginButton
    }()


    @objc func loginButtonPressed() {





        if count_loginButtonPressed == 0 {
            self.count_loginButtonPressed += 1


        }


        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // 3.0秒後に実行したい処理
            self.count_loginButtonPressed = 0
        }


    }


    // Register User Button
    lazy var registerUserButton: UIButton = {
        let registerUserButton = UIButton(frame: CGRect(x:self.view.frame.width / 2 - (150 / 2),  y:self.view.frame.height / 2 + 100, width:150, height:40))
        view.tag = 1030

        registerUserButton.layer.cornerRadius = 5.0
        registerUserButton.backgroundColor =  #colorLiteral(red: 0, green: 0.8362106681, blue: 1, alpha: 1)
        registerUserButton.setTitle("User Registration", for: .normal)
        registerUserButton.setBackgroundColor(color:  #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), forState: .highlighted)


        registerUserButton.accessibilityIdentifier = "registerUserButton"

        return registerUserButton
    }()




    //***************************************************
    //MARK:- 2FA View -
    //***************************************************
    lazy var input2FaTextField: UITextField = {
        let input2FaTextField = UITextField(frame: CGRect(x:self.view.frame.width / 2 - (250 / 2), y:self.view.frame.height / 2 - 100, width:250, height:40))
        view.tag = 1040

        // 最初に表示する文字.
        input2FaTextField.placeholder = " 2FA Code is required"

        // 枠の線を表示.
        input2FaTextField.borderStyle = UITextField.BorderStyle.roundedRect

        // Background Color Yellow
        input2FaTextField.backgroundColor =  UIColor(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)

        // Keyboard Type : Email
        input2FaTextField.keyboardType = UIKeyboardType.numberPad


        input2FaTextField.text = ""

        input2FaTextField.accessibilityLabel = "input2FaTextField"
        return input2FaTextField
    }()


    // 2FA Labels
    lazy var input2FaLabel: UILabel = {
        let input2FaLabel = UILabel(frame: CGRect(x:view.frame.width / 2 - (250 / 2), y:input2FaTextField.frame.minY - 30, width:250, height:30))

        input2FaLabel.text = " 2FA :"
        input2FaLabel.textColor = UIColor.white

        input2FaLabel.accessibilityLabel = "input2FaLabel"
        return input2FaLabel
    }()


    // send2FACode_Button
    lazy var send2FACode_Button: UIButton = {
        let send2FACode_Button = UIButton(frame: CGRect(x:self.view.frame.width / 2 - (180 / 2),  y:self.view.frame.height / 2 + 100  - 100, width:180, height:40))
        view.tag = 1030

        send2FACode_Button.layer.cornerRadius = 5.0
        send2FACode_Button.backgroundColor =  UIColor(red: 0, green: 0.8213806748, blue: 0.4752416015, alpha: 1)
        send2FACode_Button.setTitle("Send 2FA Code", for: .normal)
        send2FACode_Button.setBackgroundColor(color:  UIColor(red: 0, green: 0.4660990834, blue: 0.2602835298, alpha: 1), forState: .highlighted)



        send2FACode_Button.accessibilityIdentifier = "Send2FACode"

        return send2FACode_Button
    }()




    lazy var backLoginViewButton: UIButton = {
        let button = UIButton(frame: CGRect(x:self.view.frame.width / 2 - (150 / 2),  y:self.view.frame.height / 2 + 100, width:150, height:40))
        view.tag = 1030

        button.layer.cornerRadius = 5.0
        button.backgroundColor =  #colorLiteral(red: 0.4689772725, green: 0.6512975097, blue: 0, alpha: 1)
        button.setTitle("Back Login", for: .normal)
        button.setBackgroundColor(color:  #colorLiteral(red: 0.2514988482, green: 0.465239346, blue: 0, alpha: 1), forState: .highlighted)

        button.addTarget(self, action: #selector(backToLoginView), for: .touchDown)

        button.accessibilityIdentifier = "backLoginViewButton"

        return button
    }()


    @objc func backToLoginView() {


        // Delete 2FA Views
        input2FaTextField.removeFromSuperview()
        input2FaLabel.removeFromSuperview()
        send2FACode_Button.removeFromSuperview()
        backLoginViewButton.removeFromSuperview()




        // Add login Views
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(uploadButton)

    }






    //***************************************************
    //Mark: - for API & Delegate to
    //***************************************************

    func AuthenticateUser(messageFrame_o: String) {
        // In order not to Json Parse Error, Priviously change "null" to "\"null\""
        var json_o_NoNull: String? = ""
        if messageFrame_o.contains("null") {
            json_o_NoNull = messageFrame_o.replacingOccurrences(of: "null", with: "\"null\"")

        } else {
            json_o_NoNull = messageFrame_o
        }

        guard let json_o_str2 = json_o_NoNull else { return }

        guard let data2 = json_o_str2.data(using: .utf8) else {

            return
        }


        // if (1)
        // in order to get AccountId from AuthenticateUser without 2FA setting
        if messageFrame_o.contains("EmailVerified") {




            // if (2)
            // Login Failuer without 2FA
        } else if messageFrame_o.contains("{ \"Authenticated\":false }") {

            heightLabel.removeFromSuperview()
            heightLabel.textColor = UIColor.red
            heightLabel.text = "Email or Password are incorrect"
            view.addSubview(heightLabel)

            heightTextField.removeFromSuperview()
            heightTextField.backgroundColor =  UIColor(red: 0.9304718375, green: 0.6722643375, blue: 0.865437746, alpha: 1)
            view.addSubview(heightTextField)

            weightLabel.removeFromSuperview()
            weightLabel.textColor = UIColor.red
            view.addSubview(weightLabel)

            weightTextField.removeFromSuperview()
            weightTextField.backgroundColor =  UIColor(red: 0.9304718375, green: 0.6722643375, blue: 0.865437746, alpha: 1)
            view.addSubview(weightTextField)



        } else if messageFrame_o.contains("{ \"Authenticated\":true, \"Requires2FA\":true,") {




            // Delete Views
            heightLabel.removeFromSuperview()
            weightLabel.removeFromSuperview()
            heightTextField.removeFromSuperview()
            weightTextField.removeFromSuperview()
            uploadButton.removeFromSuperview()


            // Add 2FA Views
            view.addSubview(input2FaTextField)
            view.addSubview(input2FaLabel)
            view.addSubview(send2FACode_Button)
            view.addSubview(backLoginViewButton)

        }
    }


    // Login Button Pressed --> WS_Connected --> Send Email & Password Login WS
    func loginWS() {
        guard let Email = heightTextField.text else { return }
        guard let Password = weightTextField.text else { return }

    }


    // When WebSocketDidDisconnect, dismiss topViewController and pop up Notification for user
    func noticeWSDidDisconnect() {

        // Allert Server Disconnect
        let alertController = UIAlertController(title: "Sevrver Session is disconnected", message: "Sorry. Please Login again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "O K", style: .default, handler: nil)

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)

    }


    func LogoutEvent(messageFrame_o: String) {
        if messageFrame_o.contains("Session Logged out") {

        }

        // この処理がないと、2FA UserのLogin 画面がLogin状態に戻らない。
        DidDisconectViewReload()
    }

    func LogOut(messageFrame_o: String) {


        // この処理がないと、2FA UserのLogin 画面がLogin状態に戻らない。
        DidDisconectViewReload()

    }



    // When the device power off and WS Session off, Login Screen view is changed for the user who set 2FA
    // この処理がないと、2FA UserのLogin 画面がLogin状態に戻らない。
    func DidDisconectViewReload() {

        // Add 2FA Views
        input2FaTextField.removeFromSuperview()
        input2FaLabel.removeFromSuperview()
        send2FACode_Button.removeFromSuperview()
        backLoginViewButton.removeFromSuperview()

        // Delete Views
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(uploadButton)

    }


}



// Hide Keyboard when tap outside textfield
extension inputNameGenderBMI : UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        input2FaTextField.resignFirstResponder()

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}



// Login Button Extension
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}


//// Hide Keyboard when tap outside textfield
//extension inputNameGenderBMI : UITextFieldDelegate {
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        heightTextField.resignFirstResponder()
//        weightTextField.resignFirstResponder()
//        input2FaTextField.resignFirstResponder()
//
//    }
//
////    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
////        textField.resignFirstResponder()
////        return true
////    }
//
//}
