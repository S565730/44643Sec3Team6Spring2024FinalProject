//
//  CreateAccountVC.swift
//  AroundMe
//
//  Created by rachana on 4/17/24.
//

import UIKit
import FirebaseAuth

class CreateAccountVC: UIViewController {

    
    
   
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var checkPasswordTF: UITextField!
    
    @IBAction func rePasswordCheck(_ sender: Any) {
    }
    
    
    @IBAction func passwordCheck(_ sender: Any) {
    }
    
    @IBOutlet weak var registerBTN: UIButton!
    
    @IBAction func createUser(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty else {
                   showMessage("Please enter email!")
                   return
               }
              
               guard let password = passwordTF.text, !password.isEmpty,
                     let confirmPassword = checkPasswordTF.text, !confirmPassword.isEmpty else {
                   showMessage("Please enter password in both fields!")
                   return
               }
        if password.count < 6 {
                   messageLBL.text = "Password should be at least 6 characters long!"
               } else {
                   messageLBL.text = ""
               }
               
               guard password == confirmPassword else {
                   showMessage("Password should match!")
                   return
               }
              
               Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
                   if let error = error {
                      
                       self?.showMessage("\(error.localizedDescription)")
                   } else {
                      
                       self?.performSegue(withIdentifier: "createAccountToLogin", sender: self)
                   }
               }
    }
    func showMessage(_ message: String) {
            messageLBL.text = message
        }
    @IBAction func cancelAccountCreation(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "createAccountToLogin", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
