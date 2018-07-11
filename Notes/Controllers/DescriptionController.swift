//
//  DescriptionController.swift
//  Notes
//
//  Created by Cat on 5/23/18.
//  Copyright © 2018 Cat. All rights reserved.
//

import UIKit
import CoreLocation

class DescriptionController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var noteTextField: UITextView!
    var noteDescription: String = ""
    let newData = NoteModel()

    var locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        noteTextField.text = noteDescription
    }

    @IBAction func pressAddLocationBtn(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .authorizedAlways, .authorizedWhenInUse:
                let latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude)!
                let longitude: CLLocationDegrees = (locationManager.location?.coordinate.longitude)!
                let location = CLLocation(latitude: latitude, longitude: longitude)
                
                geoCoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        return
                    } else if let country = placemarks?.first?.country,
                        let city = placemarks?.first?.locality {
                        self.newData.location = city + ", " + country
                        
                    } else {
                    }
                })
                break
                
            case .notDetermined:
                print("Not determined.")
                break
                
            case .restricted:
                print("Restricted.")
                break
                
            case .denied:
                print("Denied.")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if noteTextField.text.isEmpty == false && noteTextField.text != noteDescription {
            let date = Date()
            let formater = DateFormatter()
            formater.dateFormat = "dd MMMM yyy, HH:mm "
            let result = formater.string(from: date)
            
            newData.creationDate = result
            newData.noteDescription = noteTextField.text
            
            Storage.shared.notes.append(newData)
        }
    }

}
