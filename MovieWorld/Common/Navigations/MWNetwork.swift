//
//  MWNetwork.swift
//  MovieWorld
//
//  Created by Admin on 02.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//
//  1. Сделать глобальную сетевую часть. Использовать для этого singleton, в котором хранится базовый урл, apiKey (79d5894567be5b76ab7434fc12879584) и настройки сессии.
//2. В синглтоне создать фукнцию request, которая принимает в виде аргументов: url path, query parameters, successHandler, errorHandler.
//successHandler - замыкание, возвращающее модель типа Decodable. Использовать дженерик для того, чтобы передавать в request конкретный тип возвращаемого значения
//errorHandler - замыкание, возвращающее ошибку (в виде структуры / перечисления). Ошибка в себе может хранить statusCode, message, description.
//Обработать следующие statusCodes: 200…300, 401, 404. Для 401 и 404 сделать модельку Decodable
//3. На главной экране реализовать 3-4 понравившихся запроса из api: https://developers.themoviedb.org/3/getting-started/introduction . Какие именно запросы на получение фильмов - выбирайте сами. Но сделать не менее 4 блоков на главноым экране.
//4. Также потребуется в самом начале делать запрос на получение списка жанров: https://developers.themoviedb.org/3/genres/get-movie-list и https://developers.themoviedb.org/3/genres/get-tv-list.
//5. Добавить pull to refresh на главном контроллере, который заново загружает все секции.

import Foundation
import Alamofire


typealias MWNet = MWNetwork
typealias SuccessHandler<T: Decodable> = (T) -> ()
typealias ErrorHandler = (Int, AFError) -> ()

class MWNetwork {
    static let sh = MWNetwork()
    
    private let apiKey: String = "79d5894567be5b76ab7434fc12879584"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p"
    
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
            .validate().responseDecodable(of: MWResponseConfiguration.self) { (response) in
                switch response.result {
                case .failure(let requestErrors):
                    guard let errorCode = response.response?.statusCode else { return }
                    self.errorHandler(errorCode, requestErrors)
                case .success(let data):
                    let config = data.images
                    MWSys.sh.configuration = config
                }
        }
    }
    
    func request<T: Decodable>(_ urlPath: String,
                                _ queryParameters: [String: Any] = ["language": URLLanquage.by.urlValue],
                                of: T.Type?,
                                successHandler: @escaping SuccessHandler<T>,
                                _ errorHandler: ErrorHandler? = nil) -> () {
        let url = baseURL + urlPath
        var params: [String: Any] = queryParameters
        params["api_key"] = self.apiKey
        
        AF.request(url, parameters: params).responseDecodable(of: T.self) { (response) in
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
}

enum MWNetError {
    case incorrectUrl(url: String)
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)
    
    case unknown
}

struct URLPaths {
    static public let popularMovies: String =  "/movie/popular"
    static public let topMovies: String =  "/movie/top_rated"
    static public let nowPlayingMovies: String = "/movie/now_playing"
    static public let genreList: String = "/genre/movie/list"
    static public let movieById: String = "/movie/"
}
    
enum URLLanquage {
    case ru
    case en
    case by
    
    var rawValue: String {
        switch self {
        case .ru:
            return "Russian"
        case .en:
            return "English"
        case .by:
            return "Russian"
        }
    }
    
    var urlValue: String {
        switch self {
        case .ru:
            return "ru-RU"
        case .en:
            return "en-US"
        case .by:
            return "ru-BY"
        }
    }
}
