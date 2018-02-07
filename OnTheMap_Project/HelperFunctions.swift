//
//  HelperFunctions.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 2/2/18.
//  Copyright © 2018 Andrew Delaney. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Function to display alerts using an alert controller
    
    func showAlert (_ title: String, _ message: String) -> () {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


    
}
