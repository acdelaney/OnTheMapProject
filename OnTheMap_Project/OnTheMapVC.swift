//
//  OnTheMapVC.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/19/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit
import MapKit

class OnTheMapVC: UIViewController, MKMapViewDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var NavigationBar: UINavigationBar!
    
    var Locations: [StudentInformation] {return StudentInformationClass.Locations}
    
    let mapViewDelegate = MapViewDelegate()


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = mapViewDelegate
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadLocations()
    }
    
    //MARK: Functions
    
    func hideNavigationBar(_ hide: Bool) -> () {
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    
    // Gets locations from Parse server and adds them to the map
    
    func loadLocations() -> () {
        
        ParseClient.sharedInstance().getStudentLocations(completionHandlerForStudentLocations: {response, error in
            if let response = response {
                StudentInformationClass.Locations = response
                
                // We will create an MKPointAnnotation for each dictionary in "locations". The
                // point annotations will be stored in this array, and then provided to the map view.
                var annotations = [MKPointAnnotation]()
                
                for student in self.Locations {

                    let lat = CLLocationDegrees(student.latitude)
                    let long = CLLocationDegrees(student.longitude)
                    
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let first = student.firstName
                    let last = student.lastName
                    let mediaURL = student.mediaURL
                    
                    // Here we create the annotation and set its coordiate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                    
                    // Finally we place the annotation in an array of annotations.
                    annotations.append(annotation)
                }
                
                // When the array is complete, we add the annotations to the map.
                performUIUpdatesOnMain {
                    self.mapView.addAnnotations(annotations)
                }
                
            } else {
                
                performUIUpdatesOnMain {
                    self.showAlert("Failure", error!.localizedDescription)
                }
            }
        })
        
    }

    //Reloads the student locations
    
    @IBAction func refreshLocations(_ sender: Any) {
        
        self.loadLocations()
        
    }
    
    // Logs out of the session and the app
    
    @IBAction func logout(_ sender: Any) {
        
        UdacityClient.sharedInstance().deleteUdacitySession { (result, error) in
            
            if let error = error {
                
                print(error)
                
                performUIUpdatesOnMain {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                
                print("Session Deleted")
                
                performUIUpdatesOnMain {
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    

    
}
