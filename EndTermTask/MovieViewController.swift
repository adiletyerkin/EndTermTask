//
//  MovieViewController.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 21.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     var results = [Result]()
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieViewCell
    
        cell.titleMovie.text = results[indexPath.row].title
        cell.dateMovie.text = results[indexPath.row].releaseDate
       // cell.overviewMovie.text = results[indexPath.row].overview
        cell.voteMovie.text = results[indexPath.row].scoreText
        let linkImage = results[indexPath.row].backdorURL
        cell.photoMovie.downloaded(from: linkImage)
        
        return cell
         
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 250
        
     }
    

    @IBOutlet weak var MovieTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMovies()
        self.MovieTable.delegate = self
        self.MovieTable.dataSource = self
//        self.MovieTable.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "cell")

    }
    
    
    
    
        func getMovies(){
            let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=d805a0f5b0ad850570cc9a742fe0afcd"
            guard let url = URL(string: urlString) else{
                print("URL in not valid")
                return
            }
            let session = URLSession.shared
            let request = URLRequest(url: url)
    
            let task = session.dataTask(with: request){
                (data, response, error) in
                guard error == nil else{
                    print("error: \(error!)")
                    return
                }
    
                guard let responseData = data else{
                    print("did not recieve data")
                    return
                }
    
            do{
                    guard let data = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] else{
                        print("error trying convert json to data")
                        return
                    }
                    let decoder = JSONDecoder()
                    let myarray = data["results"] as? [[String: Any]] ?? [[String: Any]]()
                    let json = try JSONSerialization.data(withJSONObject: myarray)
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode([Result].self, from: json)
    
                    for i in decoded{
                        print(i.title!)
    
                    }
                    self.results.append(contentsOf: decoded)
    
                    }
    
                catch{
                    print(error)
    
                }
                DispatchQueue.main.async {
                    self.MovieTable.reloadData()
                }
    
    
            }
            task.resume()
    
    
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController
        vc?.nameFilm = results[indexPath.row].title!
        vc?.dateFilm = results[indexPath.row].releaseDate!
        vc?.overTextFilm = results[indexPath.row].overview!
        vc?.voteFilm = results[indexPath.row].scoreText
//        let linkImage = results[indexPath.row].backdorURL
//        vc?.photoFilm = downloaded(from: linkImage)
        
    
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
 
    }
    
}


class MovieViewCell: UITableViewCell  {
    
    
    @IBOutlet weak var photoMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var overviewMovie: UILabel!
    @IBOutlet weak var voteMovie: UILabel!
    
    
}

extension UIImageView {
    func downloaded(from url: URL) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
