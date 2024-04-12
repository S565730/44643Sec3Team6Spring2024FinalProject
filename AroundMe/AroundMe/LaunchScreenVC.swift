//
//  LaunchScreenVC.swift
//  AroundMe
//
//  Created by rachana on 3/12/24.
//

import UIKit

class LaunchScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            self.performSegue(withIdentifier: "launchToCategories", sender: self)
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imgView: UIImageView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
