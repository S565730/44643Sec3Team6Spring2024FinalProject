//
//  ProfileVC.swift
//  AroundMe
//
//  Created by rachana on 4/19/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ProfileVC: UIViewController {



    @IBOutlet weak var EmailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmailTF.text = Auth.auth().currentUser?.email ?? ""
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            self.view.subviews.first?.frame = self.view.bounds
        
//        EmailLBL.layer.cornerRadius = 5
//        EmailLBL.layer.borderWidth = 1
            
        }
    
    
    
    @IBAction func Logout(_ sender: Any) {
        

                self.performSegue(withIdentifier: "Login", sender: self)
    }
    
   
     @IBAction func Delete(_ sender: Any) {
         let user = Auth.auth().currentUser
         
         user?.delete { error in
             if let error = error {
                 self.openAlert(title: "Alert", message: "Error deleting user: \(error.localizedDescription)", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in}])
             } else {
                 self.openAlert(title: "Alert", message: "User deleted successfully", alertStyle: .alert, actionTitles: ["okay"], actionStyles: [.default], actions: [{ _ in}])
             }
         }
         self.performSegue(withIdentifier: "Login", sender: self)
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
extension UIViewController{
    
    // Global Alert
    // Define Your number of buttons, styles and completion
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
