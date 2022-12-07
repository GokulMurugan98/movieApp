//
//  ViewController.swift
//  movieApp
//
//  Created by Gokul Murugan on 2022-12-05.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var movies:[Results] = []
    var indexToSend:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "MovieListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "myCell")
        
        DispatchQueue.global().async { [weak self] in
            self?.getResult()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexToSend = indexPath.row
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? MovieListTableViewCell else {return UITableViewCell()}
        cell.movieName.text = movies[indexPath.row].title
        DispatchQueue.global().async {
            let urlString = "https://image.tmdb.org/t/p/w500/\(self.movies[indexPath.row].poster_path)"
            let url = URL(string: urlString)
            if let url = url {
                URLSession.shared.dataTask(with: url) { Dt, _ , er in
                    if let data = Dt {
                        DispatchQueue.main.async {
                            cell.moviePoster.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
        cell.releaseDate.text = movies[indexPath.row].release_date
        cell.ratings.text = "\(movies[indexPath.row].vote_average)"
        return cell
    }
    
    
    func getResult(){
        let stringCall = "https://api.themoviedb.org/3/movie/now_playing?api_key=541ac744e08188d246878737ef57e7f9&language=en-US&page=1"
            guard let URL = URL(string: stringCall) else {
                return
        }

        let task = URLSession.shared.dataTask(with: URL) { Dt, Response, Error in
            if let Data = Dt
                {
                  do{
                      let movieData:result = try JSONDecoder().decode(result.self, from: Data)
                      self.movies = movieData.results
                      DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
                   }
                   catch let err{
                       print(err.localizedDescription)
                   }
              }
            }
            task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            if let destinationVC = segue.destination as? DetailsViewController {
                destinationVC.movieArray = movies
                destinationVC.movieIndex = indexToSend
            }
            
        }
        else{
            print("Unknown identifier")
        }
    }
   
}

struct result:Codable{
    var dates:Dates
    var page: Int
    var results: [Results]
    var total_pages: Int
    var total_results:Int
}

struct Dates:Codable{
    var maximum:String
    var minimum:String
}

struct Results:Codable{
    var adult:Bool
    var backdrop_path:String
    var genre_ids: [Int]
    var id:Int
    var original_language:String
    var original_title:String
    var overview:String
    var popularity:Double
    var poster_path:String
    var release_date: String
    var title:String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}


