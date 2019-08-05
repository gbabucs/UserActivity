//
//  UsersListViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Reachability
import SwiftyJSON
import IHProgressHUD

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var users: [Users]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private(set) var selectedUser: Users?
    
    //--------------------------------------------------------------------------
    // MARK: - properties
    //--------------------------------------------------------------------------
    
    let reachability : Reachability! = Reachability()
    
    private var isReachable: Bool {
        guard reachability.connection != .none else {
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product List"
        
        
        if isReachable {
            self.getUsersList()
        } else {
            self.showErrorAlert(fot: "No Internet Connection", message: "Please try again later")
        }
        
        startWatchingReachability()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 115
        tableView.tableFooterView = UIView()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    @objc private func getUsersList() {
        if isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            IHProgressHUD.show()
            DispatchQueue.global(qos: .default).async(execute: {
                DataController().getUsers { [weak self] users in
                    self?.users = users
                }
                IHProgressHUD.dismiss()
            })
        }
    }
    
    private func showErrorAlert(fot title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Helper functions
    //--------------------------------------------------------------------------
    
    func startWatchingReachability() {
        try? self.reachability.startNotifier()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetailViewController" {
            if let tabController = segue.destination as? UITabBarController,
                let navigationViewController  = tabController.viewControllers?.first as? UINavigationController,
                let userDetailViewController = navigationViewController.topViewController as? UserDetailViewController {
                userDetailViewController.user = selectedUser
            }
        }
    }

}


//--------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//--------------------------------------------------------------------------


extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = users?[indexPath.row]
        performSegue(withIdentifier: "showUserDetailViewController", sender: nil)
    }
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDataSource
//--------------------------------------------------------------------------

extension UsersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListCell.reuseIdentifier, for: indexPath) as? UsersListCell,
        let user = users?[indexPath.row] else { return UITableViewCell() }
        
        self.update(cell, at: user)
        
        return cell
    }
    
    func update(_ cell: UsersListCell, at user: Users) {
        cell.configure(for: user)
    }
}
