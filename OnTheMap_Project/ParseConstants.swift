//
//  Constants.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/19/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

struct ParseConstants {
    
    struct URL {
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
    }
    
    struct Method {
        static let StudentLocation = "/StudentLocation"
            
    }
        
    struct ParameterKeys {
        static let Limit = "limit"
        static let Skip = "skip"
        static let Order = "order"
            
    }
        
    struct Parameters {
        static let Limit = "100"
        static let Skip = "400"
        static let Order = "-updatedAt"
    
    }
    
    struct HeaderFields {
        static let ApplicationID = "X-Parse-Application-Id"
        static let RESTAPIKey = "X-Parse-REST-API-Key"
        static let ContentType = "Content-Type"
        
    }
    
    struct HeaderFieldsValues {
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let RESTAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ContentType = "application/json"
        
    }
    
    struct HTTPMethods {
        static let Post = "POST"
        static let Put = "PUT"
        
    }
    
    struct JSONBodyKeys {
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        
    }
    
    struct JSONResponseKeys {
        static let ObjectID = "objectId"
    }
        
        
}


    

