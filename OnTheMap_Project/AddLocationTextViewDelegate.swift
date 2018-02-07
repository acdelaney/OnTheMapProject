//
//  TextViewDelegate.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 9/18/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation
import UIKit

class AddLocationTextViewDelegate: NSObject, UITextViewDelegate {
    
    //MARK: TextView Delegate
    
    
    // Clears text on tap
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Type Here!"   {
            textView.text = ""
        }else if textView.text == "Write the link you want to share here!" {
                textView.text = ""
        }
}

    
    // Returns keyboard when return is pressed on TextView
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
}


    
    
    
    
