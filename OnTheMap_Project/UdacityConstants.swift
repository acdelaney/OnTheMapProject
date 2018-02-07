//
//  UdacityConstants.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 9/4/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//


struct UdacityConstants {
    
    struct URL {
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
    }
    
    struct Method {
        static let Session = "/session"
        static let Users = "/users"
    }
    
    struct HeaderFields {
        static let Accept = "Accept"
        static let ContentType = "Content-Type"
        
    }
    
    struct HeaderFieldsValues {
        static let Accept = "application/json"
        static let ContentType = "application/json"
        
    }
    
    struct HTTPMethods {
        static let Post = "POST"
        static let Delete = "DELETE"
    }
    
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
    }
    
    struct JSONResponseKeys {
        static let Account = "account"
        static let Session = "session"
        static let User = "user"
        static let Registered = "registered"
        static let Id = "id"
        static let Key = "key"
        
    }
    
}





