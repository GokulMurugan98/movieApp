//
//  DetailsViewController.swift
//  movieApp
//
//  Created by Gokul Murugan on 2022-12-06.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieOverView: UITextView!
    
    var movieArray:[Results]?
    var movieIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        publishData()
        movieOverView.sizeToFit()
        }
            func publishData(){
                if movieArray != nil && movieIndex != nil{
                    filmName.text = movieArray![movieIndex!].title
                    movieOverView.text = movieArray![movieIndex!].overview
                    DispatchQueue.global().async {
                        let urlString = "https://image.tmdb.org/t/p/w500/\(self.movieArray![self.movieIndex!].poster_path)"
                        let url = URL(string: urlString)
                        if let url = url {
                            URLSession.shared.dataTask(with: url) { Dt, _ , er in
                                if let data = Dt {
                                    DispatchQueue.main.async {
                                        self.moviePoster.image = UIImage(data: data)
                                    }
                                }
                            }.resume()
                        }
                        
                    }
                
                
            }
          
        }
    
    
}
    
    
