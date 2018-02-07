//
//  UdacityConvenience.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 9/4/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient {
    
    // Posts a Udacity Session and parses JSON into usable format.
    
    func postUdacitySession(_ username: String, password: String, completionHandlerforPostSession: @escaping (_ account_result: [String:AnyObject]?,_ session_result: [String:AnyObject]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //let parameters = []
        let method: String = UdacityConstants.Method.Session
        
        let jsonBody = "{\"\(UdacityConstants.JSONBodyKeys.Udacity)\": {\"\(UdacityConstants.JSONBodyKeys.Username)\": \"\(username)\", \"\(UdacityConstants.JSONBodyKeys.Password)\": \"\(password)\"}}"
        
        /* 2. Make the request */
        let _ = taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerforPostSession(nil, nil, error)
            } else {
                if let account_result = results?["\(UdacityConstants.JSONResponseKeys.Account)"] as? [String:AnyObject]  {
                    
                    if let session_result = results?["\(UdacityConstants.JSONResponseKeys.Session)"] as? [String:AnyObject] {
                        
                        completionHandlerforPostSession(account_result, session_result, nil)
                        
                    }else{
                        
                        completionHandlerforPostSession(nil, nil, NSError(domain: "postUdacitySession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postUdacitySession Session Info"]))
                        
                    }
                }else{
                    
                    completionHandlerforPostSession(nil, nil, NSError(domain: "postUdacitySession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postUdacitySession Account Info"]))
                }
            }
        }
    }
    
    // Gets the user's info from the Udacity client and parses the JSON into usable format.
    
    func getUdacityUserInfo(userKey: String?, completionHandlerForUdacityUserInfo: @escaping (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //let parameters = [ParseConstants.ParameterKeys.Limit: ParseConstants.Parameters.Limit]
        let method: String = UdacityConstants.Method.Users + "/" + userKey!
        
        
        /* 2. Make the request */
        let _ = taskForGETMethod(method, parameters: nil) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForUdacityUserInfo(nil, error)
            } else {
                
                if let results = results?["\(UdacityConstants.JSONResponseKeys.User)"] as? [String:AnyObject] {
                    
                    completionHandlerForUdacityUserInfo(results, nil)
                    
                } else {
                    completionHandlerForUdacityUserInfo(nil, NSError(domain: "getUdacityUserInfo parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getUdacityUserInfo"]))
                }
            }
        }
        
    }
    
    // Deletes the Udacity Session.
    
    func deleteUdacitySession(completionHandlerforDELETESession: @escaping (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //let parameters = []
        let method: String = UdacityConstants.Method.Session

        
        /* 2. Make the request */
        let _ = taskForDeleteMethod(method) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerforDELETESession(nil, NSError(domain: "deleteUdacitysSession", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not delete session"]))
            }else{
                completionHandlerforDELETESession(results as? [String : AnyObject], nil)

            }
        }
    }


    
    
    

    
    
    
}
