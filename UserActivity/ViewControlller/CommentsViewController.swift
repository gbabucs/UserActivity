//
//  CommentsViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Reachability
import IHProgressHUD


class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reachability : Reachability! = Reachability()
    
    public var post: Posts?
    
    private(set) var comments: [Comments]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private var isReachable: Bool {
        guard reachability.connection != .none else {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comments"
        
        if isReachable {
            self.getComments()
        } else {
            self.showErrorAlert(fot: "No Internet Connection", message: "Please try again later")
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 154
        tableView.tableFooterView = UIView()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    @objc private func getComments() {
        if isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            let id = String(describing: self.post?.id ?? 0)
            
            IHProgressHUD.show()
            DispatchQueue.global(qos: .default).async(execute: {
                DataController().getComment(id: id){ [weak self] comments in
                    self?.comments = comments
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
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//--------------------------------------------------------------------------


extension CommentsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDataSource
//--------------------------------------------------------------------------

extension CommentsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsCell.reuseIdentifier, for: indexPath) as? CommentsCell,
            let comment = comments?[indexPath.row] else { return UITableViewCell() }
        
        self.update(cell, at: comment)
        
        return cell
    }
    
    func update(_ cell: CommentsCell, at comment: Comments) {
        cell.configure(for: comment)
    }
}
