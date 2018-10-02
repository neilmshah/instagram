//
//  Post.swift
//  instagram
//
//  Created by Neil Shah on 10/1/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Post"
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let post = Post()
        
        post.media = getPFFileFromImage(image: image)!
        post.author = PFUser.current()!
        post.caption = caption!
        post.likesCount = 0
        post.commentsCount = 0
        
        post.saveInBackground(block: completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
