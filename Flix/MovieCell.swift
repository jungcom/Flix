//
//  MovieCell.swift
//  Flix
//
//  Created by Anthony Lee on 9/17/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    var movie:Movie? {
        willSet(movie) {
            titleLabel.text = movie?.title
            overviewLabel.text = movie?.overview
            if let poster = movie?.posterUrl{
                movieImageView.af_setImage(withURL: poster)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
