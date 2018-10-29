//
//  DetailViewController.swift
//  Flix
//
//  Created by Anthony Lee on 9/24/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit

enum Keys{
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let baseURL = "https://image.tmdb.org/t/p/w500"
    
}

class DetailViewController: UIViewController {
    var movie : Movie?
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let movie = movie{
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            if let backdropURL = movie.backdropURL{
                backDropImageView.af_setImage(withURL: backdropURL)
            }
            if let posterUrl = movie.posterUrl{
                posterImageView.af_setImage(withURL: posterUrl)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
