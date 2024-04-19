//
//  ResetPasswordVC.swift
//  S565730ShopcyApp
//
//  Created by rachana on 3/25/24.
//

import UIKit
import FirebaseAuth

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var messageLBL: UILabel!
    
   
    @IBOutlet weak var cancelPasswordReset: UIButton!
    
    
    
    @IBAction func onClickSendLink(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty else {
                   messageLBL.text = "Please enter email!"
                   return
               }

               // Send password reset link
               sendPasswordResetLink(email: email)
           }

           func sendPasswordResetLink(email: String) {
               Auth.auth().sendPasswordReset(withEmail: email) { error in
                   if let error = error {
                       self.messageLBL.text = " \(error.localizedDescription)"
                   } else {
                       // Password reset link sent successfully, navigate to Login View
                       self.performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
                   }
               }
           }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelPasswordRese(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "resetPasswordToLogin", sender: nil)
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
