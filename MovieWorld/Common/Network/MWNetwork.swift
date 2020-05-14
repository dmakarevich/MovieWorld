//
//  MWNetwork.swift
//  MovieWorld
//
//  Created by Admin on 02.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
//2. В синглтоне создать фукнцию request, которая принимает в виде аргументов: url path, query parameters,
// successHandler, errorHandler.
//successHandler - замыкание, возвращающее модель типа Decodable. Использовать дженерик для того, чтобы
// передавать в request конкретный тип возвращаемого значения
//errorHandler - замыкание, возвращающее ошибку (в виде структуры / перечисления).
//Ошибка в себе может хранить statusCode, message, description.
//Обработать следующие statusCodes: 200…300, 401, 404. Для 401 и 404 сделать модельку Decodable
//3. На главной экране реализовать 3-4 понравившихся запроса из api:
//https://developers.themoviedb.org/3/getting-started/introduction . Какие именно запросы на получение фильмов - выбирайте сами. Но сделать не менее 4 блоков на главноым экране.

import Foundation
import Alamofire

typealias MWNet = MWNetwork
typealias SuccessHandler<T: Decodable> = (T) -> Void
typealias ErrorHandler = (Int, AFError) -> Void
typealias CompetionImageHandler = (Data?) -> Void

class MWNetwork {
    static let sh = MWNetwork()

    private let apiKey: String = "79d5894567be5b76ab7434fc12879584"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/"

    private let errorHandler: ErrorHandler = { (errorCode, errors) in
        print("~~Errors~~")
        switch errorCode {
        case 401:
            debugPrint("Error 401: Authorization error! Check Your apiKey.")
        case 404:
            debugPrint("Error 404: Resourse not found!.")
        default:
            debugPrint("status code - \(errorCode): \(errors)")
        }
    }

    func fetchConfiguration() {
        let url = baseURL + "/configuration?api_key=" + apiKey

        AF.request(url)
            .validate()
            .responseDecodable(of: MWResponseConfiguration.self) { (response) in
                switch response.result {
                case .failure(let requestErrors):
                    guard let errorCode = response.response?.statusCode else { return }
                    self.errorHandler(errorCode, requestErrors)
                case .success(let data):
                    debugPrint(data.images)
                }
        }
    }

    func request<T: Decodable>(urlPath: String,
                               queryParameters: [String: Any] = ["language": URLLanguage.by.urlValue],
                               of: T.Type?,
                               successHandler: @escaping SuccessHandler<T>,
                               errorHandler: ErrorHandler? = nil) -> Void {
        let url = baseURL + urlPath
        var params: [String: Any] = queryParameters
        params["api_key"] = self.apiKey

        AF.request(url, parameters: params)
            .validate()
            .responseDecodable(of: T.self) { (response) in
            switch response.result {
            case .failure(let requestErrors):
                guard let errorCode = response.response?.statusCode else { return }
                if let errors = errorHandler {
                    errors(errorCode, requestErrors)
                } else {
                    self.errorHandler(errorCode, requestErrors)
                }
            case .success(let data):
                successHandler(data)
            }
        }
    }

    func getImage(imagePath path: String,
                  size: Sizes = .original,
                  handler: @escaping CompetionImageHandler) {
        let base: String = MWSys.sh.configuration?.secureImageUrl ?? imageURL
        let url = base + size.rawValue + path

        AF.request(url)
            .validate()
            .responseData { (response) in
                debugPrint(response.request?.urlRequest)
                if response.error == nil {
                    handler(response.data)
                } else {
                    debugPrint(response.error)
                }
        }
    }
}

enum MWNetError {
    case incorrectUrl(url: String)
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)

    case unknown
}

struct URLPaths {
    static let popularMovies: String =  "/movie/popular"
    static let topMovies: String =  "/movie/top_rated"
    static let nowPlayingMovies: String = "/movie/now_playing"
    static let genreList: String = "/genre/movie/list"
    static let movieById: String = "/movie/"
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
