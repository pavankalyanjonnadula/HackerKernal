//
//  ViewController.swift
//  HackerKernelTask
//
//  Created by Pavan Kalyan Jonnadula on 07/04/20.
//  Copyright © 2020 Pavan Kalyan Jonnadula. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController , URLSessionDelegate , UITextFieldDelegate{

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwaordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 3
        emailTF.delegate = self
        passwaordTF.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func loginBtnAction(_ sender: Any) {
        self.navigateToMainController()

        let headers = [
          "Content-Type": "application/json",
        ]
        let parameters = [
            "email" : emailTF.text ?? "",
            "password" : passwaordTF.text ?? "",
            
            //            "email" : "admin@gmail.com",
            //            "password" : "123456",
            "type" : "a"
            ] as [String : Any]
        do{
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "http://139.59.87.150/demo/Shree_Sai_Mall/public/api/user-login")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse as Any)
            if let responseData = data {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: responseData,options: JSONSerialization.ReadingOptions.allowFragments)
                    OperationQueue.main.addOperation {
                        print("the login Data",jsonObj)
                        let dataDict = jsonObj as? NSDictionary ?? [:]
                        if let error = dataDict.object(forKey: "errors") as? NSDictionary{
                            
                        }else{
                            self.setObject(forKey: "login", value: dataDict)
                            DispatchQueue.main.async {
                                self.navigateToMainController()

                            }
                        }
                    }
                } catch {
                    OperationQueue.main.addOperation {
                    }
                }
            }
          }
        })

        dataTask.resume()
    }catch {
        fatalError("Request could not be serialized")
    }
    }
    
    func navigateToMainController(){
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
     func setObject(forKey:String,value:AnyObject){
          //Encoding array
          let encodedArray : NSData = NSKeyedArchiver.archivedData(withRootObject: value) as NSData
          //Saving
          let defaults = UserDefaults.standard
          defaults.setValue(encodedArray, forKey:forKey)
          defaults.synchronize()
      }
    
}

