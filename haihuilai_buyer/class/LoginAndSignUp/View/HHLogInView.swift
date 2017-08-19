//
//  HHLogInView.swift
//  haihuilai_buyer
//
//  Created by jonker on 17/8/9.
//  Copyright © 2017年 haihuilai. All rights reserved.
//
typealias choiceCountryBlock = () -> ()
typealias forgetSecretBlock = () -> ()
typealias signupBlock = () -> ()
typealias loginBlock = (_ countryNumber: String?, _ phoneNumber: String?, _ secretNumber: String?) -> ()
import UIKit
final class HHLogInView: UIView, HHLoadNibDelegate{
    var choiceCountryB:choiceCountryBlock?
    var forgetSecretB:forgetSecretBlock?
    var signupB:signupBlock?
    var loginB:loginBlock?
    
    
    
    @IBOutlet weak var countryNumber: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var secretNumber: UITextField!
    @IBOutlet weak var btnForLogin: UIButton!
    
    @IBAction func contryBtn() {
        if self.choiceCountryB != nil {
            self.choiceCountryB!()
        }
    }
    @IBAction func forgetSecret() {
        if self.forgetSecretB != nil{
            self.forgetSecretB!()
        }
    }
    @IBAction func loginBtn() {
        if self.loginB != nil {
            self.loginB!(countryNumber.text, phoneNumber.text, secretNumber.text)
        }
    }
    @IBAction func signUp() {
        if self.signupB != nil {
            self.signupB!()
        }
    }
}
