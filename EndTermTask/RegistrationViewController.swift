//
//  RegistrationViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 18.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit
import Parse


class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameReg.text = ""
        passwordReg.text = ""
        self.hide()
        
    }
    

    @IBOutlet weak var userNameReg: UITextField!
    
    @IBOutlet weak var passwordReg: UITextField!
    func hide() {
           passwordReg.isSecureTextEntry = true
       }
    
    
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
            user.username = userNameReg.text
            user.password = passwordReg.text
            let sv = UIViewController.displaySpinner(onView: self.view)
            user.signUpInBackground { (success, error) in
                UIViewController.removeSpinner(spinner: sv)
                if success{
                    self.loadHomeScreen()
                }else{
                    if let descrip = error?.localizedDescription{
                        self.displayErrorMessage(message: descrip)
                    }
                }
            }
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHome2Screen()
        }
    }
    
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    func loadHome2Screen(){
           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
           self.present(loggedInViewController, animated: true, completion: nil)
       }
    
    
}
