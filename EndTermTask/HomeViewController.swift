//
//  HomeViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 18.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {

            let sv = UIViewController.displaySpinner(onView: self.view)
            PFUser.logOutInBackground { (error: Error?) in
                UIViewController.removeSpinner(spinner: sv)
                if (error == nil){
                    self.loadLoginScreen()
                }else{
                    if let descrip = error?.localizedDescription{
                        self.displayErrorMessage(message: (descrip))
                    }else{
                        self.displayErrorMessage(message: "error logging out")
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
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    


}
