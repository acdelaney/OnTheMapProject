//
//  StudentLocation.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/26/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    //MARK: Student Information Model
    
//    var createdAt: String
//    var firstName: String
//    var lastName: String
//    var latitude: Double
//    var longitude: Double
//    var mapString: String
//    var mediaURL: String
//    var objectId: String
//    var uniqueKey: String
//    var updatedAt: String
    
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    
    
    // construct a StudentInformation from a dictionary checking and replacing for nil values
    init(dictionary: [String:AnyObject]) {

//        createdAt = dictionary["createdAt"] != nil ? dictionary["createdAt"] as! String: "NO VALUE"
//        firstName = dictionary["firstName"] != nil ? dictionary["firstName"] as! String: "NO VALUE"
//        lastName = dictionary["lastName"] != nil ? dictionary["lastName"] as! String: "NO VALUE"
//        latitude = dictionary["latitude"] != nil ? dictionary["latitude"] as! Double: 0.0
//        longitude = dictionary["longitude"] != nil ? dictionary["longitude"] as! Double: 0.0
//        mapString = dictionary["mapString"] != nil ? dictionary["mapString"] as! String: "NO VALUE"
//        mediaURL = dictionary["mediaURL"] != nil ? dictionary["mediaURL"] as! String: "NO VALUE"
//        objectId = dictionary["objectId"] != nil ? dictionary["objectId"] as! String: "NO VALUE"
//        uniqueKey = dictionary["uniqueKey"] != nil ? dictionary["uniqueKey"] as! String: "NO VALUE"
//        updatedAt = dictionary["updatedAt"] != nil ? dictionary["updatedAt"] as! String: "NO VALUE"
        
        
        if let created = dictionary["createdAt"] as? String {
            createdAt = created
        } else {
            createdAt = "NO VALUE"
        }
        if let first = dictionary["firstName"] as? String {
            firstName = first
        } else {
            firstName = "NO VALUE"
        }
        if let last = dictionary["lastName"] as? String {
            lastName = last
        } else {
            lastName = "NO VALUE"
        }
        if let lat = dictionary["latitude"] as? Double {
            latitude = lat
        } else {
            latitude = 0.0
        }
        if let long = dictionary["longitude"] as? Double {
            longitude = long
        } else {
            longitude = 0.0
        }
        if let map = dictionary["mapString"] as? String {
            mapString = map
        } else {
            mapString = "NO VALUE"
        }
        if let media = dictionary["mediaURL"] as? String {
            mediaURL = media
        } else {
            mediaURL = "NO VALUE"
        }
        if let object = dictionary["objectId"] as? String {
            objectId = object
        } else {
            objectId = "NO VALUE"
        }
        if let unique = dictionary["uniqueKey"] as? String {
            uniqueKey = unique
        } else {
            uniqueKey = "NO VALUE"
        }
        if let updated = dictionary["updatedAt"] as? String {
            updatedAt = updated
        } else {
            updatedAt = "NO VALUE"
        }
        
        
        
        
//        createdAt = createdAt.isEmpty ? "NO VALUE" : createdAt
//        firstName = firstName.isEmpty ? "NO VALUE" : firstName
//        lastName = lastName.isEmpty ? "NO VALUE" : lastName
//        mapString = mapString.isEmpty ? "NO VALUE" : mapString
//        mediaURL = mediaURL.isEmpty ?  "NO VALUE" : mediaURL
//        objectId = objectId.isEmpty ?  "NO VALUE" : objectId
//        uniqueKey = uniqueKey.isEmpty ?  "NO VALUE" : uniqueKey
//        updatedAt = updatedAt.isEmpty ?  "NO VALUE" : updatedAt
    
    }
    
    
    //Takes dictionary and creates Student Information structs
    
    static func locationsFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var locations = [StudentInformation]()
        
        // iterate through array of dictionaries, each student location is a dictionary
        for result in results {
            locations.append(StudentInformation(dictionary: result))
        }
       
        return locations
    }


    
    
    
    
    
    
    
    
    
    
}
