//
//  DetailsViewController.swift
//  rotten
//
//  Created by Niaz Jalal on 9/16/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var film: NSDictionary = NSDictionary()
    
    var hud: MBProgressHUD = MBProgressHUD()

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var detailsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the movie title directly in navigation controller
        self.title = self.film["title"] as? String
        
        var posters = film["posters"] as NSDictionary
        var posterUrl = posters["original"] as String
        
        var fixImage = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
        
        self.posterImage.setImageWithURL(NSURL(string: fixImage))
        
        self.detailsView.text = film["synopsis"] as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
