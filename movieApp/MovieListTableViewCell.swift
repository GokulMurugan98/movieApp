//
//  MovieListTableViewCell.swift
//  movieApp
//
//  Created by Gokul Murugan on 2022-12-06.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
