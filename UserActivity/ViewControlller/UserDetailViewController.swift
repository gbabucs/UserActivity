//
//  UserDetailViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    public var user: Users?
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "User Information"
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        determineCurrentLocation()
    }
    
    func setupView() {
        self.name.text = user?.name
        self.userName.text = user?.username
        self.email.text = user?.email
        
        let street = user?.address?.street ?? ""
        let suite = user?.address?.suite ?? ""
        let city = user?.address?.city ?? ""
        let zipCode = user?.address?.zipcode ?? ""
        
        self.address.text = street + suite + city + zipCode
        self.phone.text = user?.phone
        self.website.text = user?.website
        
        let companyName = user?.company?.name ?? ""
        let companyCatchPhrase = user?.company?.catchPhrase ?? ""
        let companyBS = user?.company?.bs ?? ""
        
        self.company.text = companyName + companyCatchPhrase + companyBS
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showAlbum(_ sender: Any) {
        performSegue(withIdentifier: "showAlbumViewController", sender: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumViewController" {
            if let albumViewController = segue.destination as? AlbumViewController {
                albumViewController.user = self.user
            }
        }
    }
    
}

extension UserDetailViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = Double(user?.address?.geo?.lat ?? "")
        let longitude = Double(user?.address?.geo?.lng ?? "")
        let userLocation: CLLocation = CLLocation(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        mapView.setRegion(region, animated: true)
        
        let annotationView: MKPointAnnotation = AnnotationView(user: user, location: userLocation)
        
        mapView.addAnnotation(annotationView)
    }
}

extension UserDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
