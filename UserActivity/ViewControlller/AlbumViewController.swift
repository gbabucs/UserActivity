//
//  AlbumViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Reachability
import IHProgressHUD

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private(set) var albums: [Albums]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    private(set) var selectedAlbums: Albums?
    
    public var user: Users?
    
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
        
        self.title = "Album List"
        
        
        if isReachable {
            self.getAlbumList()
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
    
    @objc private func getAlbumList() {
        if isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            IHProgressHUD.show()
            
            let userID = String(describing: user?.id ?? 0)
            DispatchQueue.global(qos: .default).async(execute: {
                DataController().getAlbum(id: userID) { [weak self] albums in
                    self?.albums = albums
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
        if segue.identifier == "showPhotoViewController" {
            if let photoViewController = segue.destination as? PhotoViewController {
                photoViewController.album = selectedAlbums
            }
        }
    }

}

//--------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//--------------------------------------------------------------------------


extension AlbumViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedAlbums = albums?[indexPath.row]
        performSegue(withIdentifier: "showPhotoViewController", sender: nil)
    }
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDataSource
//--------------------------------------------------------------------------

extension AlbumViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as? AlbumCell,
            let album = albums?[indexPath.row] else { return UITableViewCell() }
        
        self.update(cell, at: album)
        
        return cell
    }
    
    func update(_ cell: AlbumCell, at album: Albums) {
        cell.configure(for: album)
    }
}
