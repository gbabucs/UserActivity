//
//  PostsViewController.swift
//  UserActivity
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import UIKit
import Reachability
import IHProgressHUD

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let reachability : Reachability! = Reachability()
    
    private(set) var posts: [Posts]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private(set) var selectedPost: Posts?
    
    private var isReachable: Bool {
        guard reachability.connection != .none else {
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Posts"

        if isReachable {
            self.getPosts()
        } else {
            self.showErrorAlert(fot: "No Internet Connection", message: "Please try again later")
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 115
        tableView.tableFooterView = UIView()
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    @objc private func getPosts() {
        if isReachable {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            let navigationViewController  = self.tabBarController?.viewControllers?.first as? UINavigationController
            
            let userDetailViewController = navigationViewController?.topViewController as? UserDetailViewController
            
            let postId = String(describing: userDetailViewController?.user?.id ?? 0)
            
            IHProgressHUD.show()
            DispatchQueue.global(qos: .default).async(execute: {
                DataController().getPost(id: postId){ [weak self] posts in
                    self?.posts = posts
                }
                IHProgressHUD.dismiss()
            })  
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Helper functions
    //--------------------------------------------------------------------------
    
    func startWatchingReachability() {
        try? self.reachability.startNotifier()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCommentsViewController" {
            if let commentViewController = segue.destination as? CommentsViewController {
                commentViewController.post = selectedPost
            }
        }
    }
 
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

//--------------------------------------------------------------------------
// MARK: - UITableViewDelegate
//--------------------------------------------------------------------------


extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPost = posts?[indexPath.row]
        performSegue(withIdentifier: "showCommentsViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//--------------------------------------------------------------------------
// MARK: - UITableViewDataSource
//--------------------------------------------------------------------------

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsListCell.reuseIdentifier, for: indexPath) as? PostsListCell,
            let post = posts?[indexPath.row] else { return UITableViewCell() }
        
        self.update(cell, at: post)
        
        return cell
    }
    
    func update(_ cell: PostsListCell, at post: Posts) {
        cell.configure(for: post)
    }
}
