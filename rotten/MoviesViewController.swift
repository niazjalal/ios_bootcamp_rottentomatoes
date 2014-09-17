//
//  MoviesViewController.swift
//  rotten
//
//  Created by Niaz Jalal on 9/10/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary] = []
    var hud: MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var refresh: UIRefreshControl = UIRefreshControl()
        
        var textColor = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: textColor)
        refresh.addTarget(self, action: "onRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        refresh.tintColor = UIColor.whiteColor()
        tableView.addSubview(refresh)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("I'm at row: \(indexPath.row), section: \(indexPath.section)")
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["profile"] as String
        
        var fixPoster = posterUrl.stringByReplacingOccurrencesOfString("tmb", withString: "pro")
        
        cell.posterView.setImageWithURL(NSURL(string: fixPoster))
        
        //cell.textLabel!.text = "Hello, I'm at row: \(indexPath.row), section: \(indexPath.section)"
        
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var detailsViewController : DetailsViewController = segue.destinationViewController as DetailsViewController
        
        //println("indexPath = \(tableView.indexPathForCell(sender as MovieCell))")
        
        var filmIndex = tableView.indexPathForCell(sender as MovieCell)!
        
        var movie = self.movies[filmIndex.row]
        
        detailsViewController.film = movie
    }
    
    func getData() -> Void {
        
        self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.hud.mode = MBProgressHUDModeIndeterminate
        self.hud.labelText = "Loading..."
        
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=suyp4tp4qz9ay2funn7pymvj&limit=20&country=us"
        
        var request = NSURLRequest(URL: NSURL(string: url))
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error:NSError!) -> Void in
            
            if error != nil {
                TSMessage.showNotificationInViewController(self, title: "Network Error!", subtitle: error.localizedDescription, type: TSMessageNotificationType.Error, duration: -1, canBeDismissedByUser: true)
            } else {
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                
                //println("object: \(object)")
                
                self.movies = object["movies"] as [NSDictionary]
                
                
                self.tableView.reloadData()
            }
            
            self.hud.hide(true)
            
        }
    }
    
    func onRefresh(sender: AnyObject) {
        
        var refresh = sender as UIRefreshControl
        refresh.endRefreshing()
        getData()
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
