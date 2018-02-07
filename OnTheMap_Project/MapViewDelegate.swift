
//
//  MapViewDelegate.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/26/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate
    
    // Create a view with a "right callout accessory view".
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
          
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil )
            }
            
        }
    }
    

    
    
    
    
    
    
    
}
