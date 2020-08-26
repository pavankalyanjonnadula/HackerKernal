//
//  SideMenuVC.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit
import SideMenu
class SideMenuVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    var viewnavigationController: UINavigationController?
    var sideMenuTabBar : UITabBarController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = getObject(forKey: "login") as? NSDictionary ?? [:]
        let loginData = data.object(forKey: "data") as? NSDictionary ?? [:]
        email.text = loginData.object(forKey: "email") as? String ?? "admin@gmail.com"
        name.text = "   \(loginData.object(forKey: "name") as? String ?? "Admin Bhai")"
        mobile.text = loginData.object(forKey: "mobile") as? String ?? "9999999999"
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backGroundViewTapped(_:))))
        self.view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func backGroundViewTapped(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "login")
        self.dismiss(animated: false, completion: nil)

        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.sideMenuTabBar?.tabBar.isHidden = true
        self.viewnavigationController?.pushViewController(loginVC, animated: true)
    }

    func getObject(forKey:String)->AnyObject? {
             let defaults = UserDefaults.standard
             var decodedArray : AnyObject!
             //Checking if the data exists
             if defaults.data(forKey: forKey) != nil {
                 //Getting Encoded Array
                 let encodedArray = defaults.data(forKey: forKey)
                 //Decoding the Array
                 decodedArray = NSKeyedUnarchiver.unarchiveObject(with: encodedArray!) as AnyObject
             }
             return decodedArray
         }

}
