//
//  OnTheMapTableVC.swift
//  OnTheMap_Project
//
//  Created by Andrew Delaney on 8/19/17.
//  Copyright © 2017 Andrew Delaney. All rights reserved.
//

import UIKit

class OnTheMapTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //MARK: Outlets
    
    @IBOutlet weak var mapTableView: UITableView!
    
     var Locations: [StudentInformation] {return StudentInformationClass.Locations }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapTableView.delegate = self
        self.mapTableView.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapTableView.reloadData()
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadStudentLocations()
    
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.Locations.count
        
    }

    // Each row in the table will have the user's name and a PIN image
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinLocation")!
        let pin = self.Locations[(indexPath as NSIndexPath).row]
        
        print(self.Locations)

        cell.imageView?.image = #imageLiteral(resourceName: "icon_pin")
        cell.textLabel?.text = pin.firstName + " " + pin.lastName

        return cell
    }

    // Opens the link that was shared when the row is tapped.  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let app = UIApplication.shared
        let toOpen = self.Locations[(indexPath as NSIndexPath).row].mediaURL
        if toOpen == "NO VALUE" {
            self.showAlert("Failure", "Invalid URL")
        }else {
             app.open(URL(string: toOpen)!, options: [:], completionHandler: nil )
        }
    
    }
    
    // Reloads student locations
    
    @IBAction func refreshLocations(_ sender: Any) {
        self.loadStudentLocations()
    }
    
    //Logs out of session and the app
    
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


    //Loads student locations from the Parse server and adds them to the table.
    
    func loadStudentLocations() -> () {
        ParseClient.sharedInstance().getStudentLocations(completionHandlerForStudentLocations: {response, error in
            if let response = response {
                
                performUIUpdatesOnMain {
                    
                    StudentInformationClass.Locations = response
                    self.mapTableView.reloadData()
                }
                
            }else{
                
                performUIUpdatesOnMain {
                    self.showAlert("Failure", error!.localizedDescription)
                    
                }
            }
        })
    }

}
    
    
    

    

