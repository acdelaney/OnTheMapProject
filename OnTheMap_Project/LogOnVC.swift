//
//  LogOnVC.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 7/30/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit

class LogOnVC: UIViewController, UITextFieldDelegate {

    
    
    //MARK: Outlets
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar(true)
        self.logoImage.image = #imageLiteral(resourceName: "logo-u")
        self.logoImage.contentMode = .scaleAspectFit
        emailTextField.delegate = self
        passwordTextField.delegate = self
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    //MARK: Functions
    
    func hideNavigationBar(_ hide: Bool) -> () {
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    

    // Opens browser to Udacity Sign Up page 
    
    @IBAction func signUpUdacity(_ sender: Any) {
        
        let app = UIApplication.shared
        let udacityAddress = "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated"
        app.open(URL(string: udacityAddress)!, options: [:], completionHandler: nil )
        
    }
    
    
    // Logs in to app using Udacity Client to verify user and password are correct
    
    @IBAction func logOnUdacity () {
        
        let username = emailTextField.text as String!
        let password = passwordTextField.text as String!
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        UdacityClient.sharedInstance().postUdacitySession(username!, password: password!, completionHandlerforPostSession: {account_result, session_result, error in
            
            if let error = error {
                
                performUIUpdatesOnMain {
                    self.showAlert("Failed to Login", error.localizedDescription)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }

            }else{
                
                //Checks to see if student is registered and if so adds the user id and session id to the Udacity Client model to be used later.
                
                if let account_result = account_result {
                    
                    
                    if account_result[UdacityConstants.JSONResponseKeys.Registered] as! Bool == true {
                        
                        if let session_result = session_result {
                            
                            UdacityClient.sharedInstance().userID = account_result[UdacityConstants.JSONResponseKeys.Key] as? String
                            UdacityClient.sharedInstance().sessionID = session_result[UdacityConstants.JSONResponseKeys.Id] as? String
                            
                            performUIUpdatesOnMain {
                                
                                // Performs segue on successful login and clears textfields
                                
                                self.performSegue(withIdentifier: "successfulLogIn", sender: self)
                                self.emailTextField.text = ""
                                self.passwordTextField.text = ""
                            }
                            
                            performUIUpdatesOnMain {
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                            }
                           
                            
                        }
                        
                    }
                }
            }
        })
    }
    
    //MARK: Keyboard Functions

    //Following functions relate to subscribing and unsubscribing to notifications for the keyboard
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //Following functions are used for showing and hiding the keyboard as well as moving the view up when the bottom textField is being edited
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if passwordTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        
        
    }
    
    //resign keyboard on return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }

    
}
