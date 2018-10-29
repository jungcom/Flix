//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Anthony Lee on 9/15/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var movies : [Movie] = []
    var refreshControl: UIRefreshControl!
    
    func fetchPopularMovies() {
        activityIndicator.startAnimating()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                let alertController = UIAlertController(title: "Network Error", message: "The Internet connection seems to be offline", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                alertController.addAction(cancel)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // TODO: Get the array of movies
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = Movie.movies(dictionaries: movieDictionaries)
                
                // TODO: Reload your table view data
                self.tableView.reloadData()
                
                // Close refresher
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        self.tableView.rowHeight = 230
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPull(_:)), for: .valueChanged)
        self.tableView.insertSubview(refreshControl, at:0)
        
        MovieAPIClient().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[(indexPath.row)]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
 
    
    @objc func didPull(_ refreshControl:UIRefreshControl){
        fetchPopularMovies()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        return cell
    }
}
