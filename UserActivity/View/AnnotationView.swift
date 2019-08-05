//
//  AnnotationView.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnnotationView: MKPointAnnotation {
    
    init(user: Users?, location: CLLocation) {
        super.init()
        
        self.title = user?.name
        self.subtitle = user?.address?.city
        self.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
    }

}
