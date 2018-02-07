//
//  ParseConvenience.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 9/4/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation
import UIKit

extension ParseClient {
    
    //Gets student locations from Parse server.
    
    func getStudentLocations(completionHandlerForStudentLocations: @escaping (_ result: [StudentInformation]?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParseConstants.ParameterKeys.Limit: ParseConstants.Parameters.Limit, ParseConstants.ParameterKeys.Order: ParseConstants.Parameters.Order]
        let method: String = ParseConstants.Method.StudentLocation
        
        
        /* 2. Make the request */
        let _ = taskForGETMethod(method, parameters: parameters as [String:AnyObject]) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForStudentLocations(nil, error)
            } else {
                
                if let results = results?["results"] as? [[String:AnyObject]] {
                    print("Before Struct")
                    print(results)
                    let locations = StudentInformation.locationsFromResults(results)
                    completionHandlerForStudentLocations(locations, nil)
                } else {
                    completionHandlerForStudentLocations(nil, NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations"]))
                }
            }
        }

    }
    
    //Posts a student location to the Parse server.
    
    func postStudentLocation(_ uniqueKey: String, firstName: String, lastName: String, mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandlerforPostStudentLocation: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //let parameters = []
        let method: String = ParseConstants.Method.StudentLocation
        
        let jsonBody = "{\"\(ParseConstants.JSONBodyKeys.UniqueKey)\": \"\(uniqueKey)\", \"\(ParseConstants.JSONBodyKeys.FirstName)\": \"\(firstName)\", \"\(ParseConstants.JSONBodyKeys.LastName)\": \"\(lastName)\",\"\(ParseConstants.JSONBodyKeys.MapString)\": \"\(mapString)\", \"\(ParseConstants.JSONBodyKeys.MediaURL)\": \"\(mediaURL)\",\"\(ParseConstants.JSONBodyKeys.Latitude)\": \(latitude), \"\(ParseConstants.JSONBodyKeys.Longitude)\": \(longitude)}"
        
        /* 2. Make the request */
        let _ = taskForPOSTMethod(method, jsonBody: jsonBody) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerforPostStudentLocation(nil, error)
            } else {
                if let results = results?["\(ParseConstants.JSONResponseKeys.ObjectID)"] as? String  {
                    
                    completionHandlerforPostStudentLocation(results, nil)
                        
                }else{
                
                    completionHandlerforPostStudentLocation(nil, NSError(domain: "postStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postStudentLocation result"]))
                        
                    }
            
                }
            }
        }
    }


    

