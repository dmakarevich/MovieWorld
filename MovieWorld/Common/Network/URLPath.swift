//
//  URLPath.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct URLPaths {
    static let popularMovies: String =  "/movie/popular"
    static let topMovies: String =  "/movie/top_rated"
    static let nowPlayingMovies: String = "/movie/now_playing"
    static let genreList: String = "/genre/movie/list"
    static let movieById: String = "/movie/"
    static let confiurations: String = "/configuration"
}

enum URLPath {
    case popularMovies
    case topMovies
    case nowPlayingMovies

    var urlValue: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .topMovies:
            return "/movie/top_rated"
        case .nowPlayingMovies:
            return "/movie/now_playing"
        }
    }

    var getTitle: String {
        switch self {
        case .popularMovies:
            return "Popular Movies"
        case .topMovies:
            return "Top movies"
        case .nowPlayingMovies:
            return "Now Playing"
        }
    }
}
