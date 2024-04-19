//
//  LaunchScreenVC.swift
//  AroundMe
//
//  Created by rachana on 3/12/24.
//

import UIKit
import AudioToolbox

class LaunchScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        AudioServicesPlaySystemSound(1332)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            self.performSegue(withIdentifier: "SplashToLogin", sender: self)
            AudioServicesPlaySystemSound(1303)
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imgView: UIImageView!
   // var openingSound = SystemSoundID(1104)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
