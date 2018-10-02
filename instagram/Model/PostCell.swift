//
//  PostCell.swift
//  instagram
//
//  Created by Neil Shah on 10/1/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var instaPostImageView: UIImageView!
    @IBOutlet weak var instaPostCaptionLabel: UILabel!
    
    var indexpath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
