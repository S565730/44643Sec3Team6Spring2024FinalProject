//
//  LoginVC.swift
//  S565730ShopcyApp
//
//  Created by rachana on 3/25/24.
//

import UIKit
import Lottie
import FirebaseAuth
class LoginVC: UIViewController {
    @IBOutlet weak var LoginLAV: LottieAnimationView!
    
   
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBTN: UIButton!
    
    @IBAction func onLogin(_ sender: Any) {
        guard let email = usernameTF.text, !email.isEmpty else {
            displayErrorMessage("Please enter Email!")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            displayErrorMessage("Please enter Password!")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                
                self?.displayErrorMessage("Invalid Login Credentials! Please try again.")
                print("Error signing in:", error)
            } else {
                
                self?.performSegue(withIdentifier: "loginToProducts", sender: nil)
            }
        }
        
    }
           @IBAction func onForgotPassword(_ sender: UIButton) {
            
               performSegue(withIdentifier: "forgotPassword", sender: self)
           }

           @IBAction func onSignUp(_ sender: UIButton) {
            
               performSegue(withIdentifier: "signUp", sender: self)
           }

           func  displayErrorMessage(_ message: String) {
               messageLBL.text = message
           }

           
           func loginSuccessful(username: String, password: String) -> Bool {
               
               return true
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playLoginAnimation()
        // Do any additional setup after loading the view.
    }
    func playLoginAnimation() {
           
            if let animation = LottieAnimation.named("Shopcy_Login") {
                LoginLAV.animation = animation
                LoginLAV.loopMode = .loop // Play animation in loop mode
                LoginLAV.play()
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
