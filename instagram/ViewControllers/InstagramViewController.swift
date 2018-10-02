//
//  InstagramViewController.swift
//  instagram
//
//  Created by Neil Shah on 9/29/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import Parse

class InstagramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Insert refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        fetchPosts()
    }
    
    @objc func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        // Fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts, error) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            else {
                print(error.debugDescription)
            }
        })
        tableView.reloadData()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogOut"), object: nil)
    }
    
    @IBAction func onNewPost(_ sender: Any) {
        self.performSegue(withIdentifier: "newPostSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        //print(post.caption)
        cell.instaPostCaptionLabel.text = post.caption
        cell.indexpath = indexPath
        if let imageFile : PFFile = post.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    cell.instaPostImageView.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }
    
    //segue for detailView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? PostCell {
            let detailView = segue.destination as! InstaDetailViewController
            detailView.post = posts[(cell.indexpath?.row)!]
        }
    }

}
