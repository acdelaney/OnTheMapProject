//
//  AddLocationVC.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 9/10/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit
import MapKit

class AddLocationVC: UIViewController, MKMapViewDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var locationPromptsStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myLocationMapView: MKMapView!
    @IBOutlet weak var findOnTheMapButton: UIButton!
    @IBOutlet weak var studyPromptTextView: UITextView!
    @IBOutlet weak var linkPromptTextView: UITextView!
    @IBOutlet weak var studyLocationTextView: UITextView!
    
    var myLocation: CLLocation!
    let mapViewDelegate = MapViewDelegate()
    let textViewDelegate = AddLocationTextViewDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLocationMapView.delegate = mapViewDelegate
        self.linkPromptTextView.delegate = textViewDelegate
        self.studyLocationTextView.delegate = textViewDelegate
        
        // Gets user info on load so that it can be used when posting to Parse
        
        UdacityClient.sharedInstance().getUdacityUserInfo(userKey: UdacityClient.sharedInstance().userID, completionHandlerForUdacityUserInfo: {results, error in
            if let error = error {
                
                performUIUpdatesOnMain {
                    self.showAlert("Failed to Get User Info", error.localizedDescription)
                }
                
            }else{
              
                UdacityClient.sharedInstance().firstName = results?["first_name"] as? String
                UdacityClient.sharedInstance().lastName = results?["last_name"] as? String
                
            }
            })

        
    }

    // Dismisses View Controller
    
    @IBAction func cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // Geocodes the location and zooms into a local region around it.  Also moves views to the back of the stack to make the map and link sharing text view visible.
    @IBAction func findOnMap(_ sender: Any) {
        
        let myLocation = self.studyLocationTextView.text!
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        // Geocodes address
        
        CLGeocoder().geocodeAddressString(myLocation){ formatedLocation, error in
            
            if let error = error{
                performUIUpdatesOnMain {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    print(error)
                    self.showAlert("Failed to Find", "The geocoding was unable to complete." )
                    
                }
                
            }else{
                
                self.myLocation = (formatedLocation?[0].location)!
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.myLocation.coordinate
                annotation.title = "\(UdacityClient.sharedInstance().firstName!) \(UdacityClient.sharedInstance().lastName!)"
                annotation.subtitle = myLocation
                
                let mapRegion = MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(0.5, 0.5) )
                
                performUIUpdatesOnMain {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.myLocationMapView.addAnnotation(annotation)
                    self.myLocationMapView.setRegion(mapRegion, animated: true)
                    self.view.sendSubview(toBack: self.findOnTheMapButton)
                    self.view.sendSubview(toBack: self.locationPromptsStackView)
                    
                }
            }
        }
    }
    
    // Posts User location, user info, and link to the Parse server and dismisses the View Controller back to the table or Map.
    
    @IBAction func submitLocation(_ sender: Any) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        ParseClient.sharedInstance().postStudentLocation(UdacityClient.sharedInstance().userID!, firstName: UdacityClient.sharedInstance().firstName!, lastName: UdacityClient.sharedInstance().lastName!, mapString: studyLocationTextView.text, mediaURL: linkPromptTextView.text, latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude, completionHandlerforPostStudentLocation: { objectID, error in
            
            if let error = error {
                performUIUpdatesOnMain {
                    self.showAlert("Failed to Post", error.localizedDescription)
                }
                
            }else{
                
                performUIUpdatesOnMain {
                    ParseClient.sharedInstance().objectID = objectID
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    
   
    
    
}
