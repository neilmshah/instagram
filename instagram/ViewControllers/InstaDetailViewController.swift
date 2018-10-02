//
//  InstaDetailViewController.swift
//  instagram
//
//  Created by Neil Shah on 10/1/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import Parse

class InstaDetailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPostDetail()
    }
    
    func loadPostDetail() {
        if let imageFile : PFFile = post?.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    self.detailImageView.image = UIImage(data: data!)
                }
            }
            captionLabel.text = post?.caption
            timeStampLabel.text = formatDateString((post?.createdAt)!)
        }
    }
    
    func formatDateString(_ date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let result = formatter.string(from: date)
        return result
    }


}
