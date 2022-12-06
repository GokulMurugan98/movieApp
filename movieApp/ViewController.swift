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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DispatchQueue.global().async { [weak self] in
            self?.getResult()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = movies[indexPath.row].title
       // cell?.detailTextLabel?.text = movies[indexPath.row].overview
        return cell!
    }
    
    
    func getResult(){
        let stringCall = "https://api.themoviedb.org/3/movie/now_playing?api_key=2be38a97dea1ca4aaa4d180f36bf6b8a&language=en-US&page=2"

    
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


