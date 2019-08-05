//
//  ViewControllerExtension.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert(fot title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
