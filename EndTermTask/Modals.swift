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

struct MovieResponse: Decodable{
    let results : [Movie]
    
}

struct Movie: Decodable{
    let id: Int
    let title: String
    let vote_average : Double
    let overview : String
    let release_date : String
    let backdrop_path : String?
    let poster_path : String?
    
}
