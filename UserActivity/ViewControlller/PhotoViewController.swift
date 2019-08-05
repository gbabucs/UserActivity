//
//  PhotoViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Reachability
import IHProgressHUD
import ActivityFramework

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var album: Albums?

    let reachability : Reachability! = Reachability()
    
    private(set) var photos: [Photos]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    private var isReachable: Bool {
        guard reachability.connection != .none else {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photos"
        
        
        if isReachable {
            self.getPhotos()
        } else {
            self.showErrorAlert(fot: "No Internet Connection", message: "Please try again later")
        }
        
        startWatchingReachability()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    @objc private func getPhotos() {
        if isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            IHProgressHUD.show()
            
            let albumId = String(describing: album?.id ?? 0)
            DispatchQueue.global(qos: .default).async(execute: {
                DataController().getPhoto(id: albumId) { [weak self] photos in
                    self?.photos = photos
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
    
}

//--------------------------------------------------------------------------
// MARK: - UICollectionViewDelegate
//--------------------------------------------------------------------------


extension PhotoViewController: UICollectionViewDelegate {}

//--------------------------------------------------------------------------
// MARK: - UICollectionViewDataSource
//--------------------------------------------------------------------------

extension PhotoViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.reuseIdentifier, for: indexPath) as? PhotoCollectionCell,
            let photo = photos?[indexPath.row] else { return UICollectionViewCell() }
        
        self.update(cell, at: photo)
        
        return cell
    }
    
    func update(_ cell: PhotoCollectionCell, at photo: Photos) {
        cell.configure(for: photo)
    }
}

// MARK: - Collection View Flow Layout Delegate
extension PhotoViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let width = DeviceInfo.Orientation.isPortrait ? view.frame.width : view.frame.height
        
        let availableWidth = width - paddingSpace
        
        let widthPerItem = availableWidth / itemsPerRow
        
        print(availableWidth)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

