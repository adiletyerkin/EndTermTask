//
//  Modals.swift
//  EndTermTask
//
//  Created by Macbook Pro 2020 on 11.12.2020.
//  Copyright © 2020 Macbook Pro 2020. All rights reserved.
//

import Foundation



class Character  : Decodable{
//        var house : AnyObject?
        var name : String
//        var quotes : [String]
        var slug : String
}

class House : Decodable{

var members : [Member]?
var name : String?
var slug : String?
}

class Member : Decodable{

var name : String?
var slug : String?
}



class RootClass{

var page : Int?
var results : [Result]?
var totalPages : Int?
var totalResults : Int?
}

class Result : Decodable{

var adult : Bool?
var backdropPath : String?
var genreIds : [Int]?
var id : Int?
var mediaType : String?
var originalLanguage : String?
var originalTitle : String?
var overview : String?
var popularity : Float?
var posterPath : String?
var releaseDate : String?
var title : String?
var video : Bool?
var voteAverage : Float?
var voteCount : Int?
    
    var backdorURL : URL{
        return URL(string: "https://image.tmdb.org/t/p/original/\(backdropPath ?? "")")!
    }

    var scoreText : String{
        var ratingText: String{
            let rating = Int(voteAverage ?? 0)
            let ratingText = (0..<rating).reduce(""){
                (acc, _) -> String in
                return acc + "☆"
            }
        return ratingText
        }

        guard ratingText.count > 0 else {
            return "n/a"
        }
        return ratingText + "\n \(ratingText.count)/10"
    }
}



//class MovieResponse{
//    var results : [Movie]?
//
//}
//class Movie: Decodable{
//    var id: Int
//    var title: String
//    var vote_average : Double
//    var overview : String
//    var release_date : String
//    var backdrop_path : String?
//    var poster_path : String?
//
//    var backdorURL : URL{
//        return URL(string: "https://image.tmdb.org/t/p/original/\(backdrop_path ?? "")")!
//    }
//
//    var ratingText: String{
//        return String(vote_average)
//    }
//
//}
//
