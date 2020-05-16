//
//  MWNetwork.swift
//  MovieWorld
//
//  Created by Admin on 02.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire

typealias MWNet = MWNetwork
typealias SuccessHandler<T: Decodable> = (T) -> Void
typealias ErrorHandler = (Int, AFError) -> Void
typealias CompetionImageHandler = (Data?) -> Void
typealias CompletionHandler = (Result<MWResponseConfiguration, MWNetError>) -> Void

class MWNetwork {
    static let sh = MWNetwork()

    private let apiKey: String = "79d5894567be5b76ab7434fc12879584"
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let imageURL: String = "https://image.tmdb.org/t/p/"
    private let parameters: [String: String] = ["api_key": "79d5894567be5b76ab7434fc12879584"]

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

    func requestAlamofire<T: Decodable>(url: String,
                                        parameters: [String: String]? = nil,
                                        successHandler: @escaping (T) -> Void,
                                        errorHandler: @escaping (MWNetError) -> Void) {
        let fullPath = self.baseURL + url

        var urlParameters = self.parameters
        if let parameters = parameters {
            for paramater in parameters {
                urlParameters[paramater.key] = paramater.value
            }
        }

        AF
            .request(fullPath, parameters: urlParameters)
            .responseJSON { (response) in
                if let error = response.error {
                    errorHandler(.networkError(error: error))
                    return
                } else if let data = response.data,
                    let httpResponse = response.response {
                    switch httpResponse.statusCode {
                    case 200...300:
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            successHandler(model)
                        } catch let error {
                            errorHandler(.parsingError(error: error))
                        }
                    case 401, 404:
                        // TODO: - write error response model handling
                        break
                    default:
                        errorHandler(.serverError(statusCode: httpResponse.statusCode))
                    }
                } else {
                    errorHandler(.unknown)
                }
        }
    }

    func requestImage(imagePath path: String,
                      size: Sizes = .original,
                      handler: @escaping CompetionImageHandler) {
        let base: String = MWSys.sh.configuration?.secureImageUrl ?? imageURL
        let url = base + size.rawValue + path

        AF.request(url)
            .validate()
            .responseData { (response) in
                if response.error == nil {
                    handler(response.data)
                }
        }
    }
}
