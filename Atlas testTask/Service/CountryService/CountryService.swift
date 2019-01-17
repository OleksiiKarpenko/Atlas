//
//  CountryService.swift
//  Atlas testTask
//
//  Created by Oleksii Karpenko on 1/16/19.
//  Copyright © 2019 Oleksii Karpenko. All rights reserved.
//

import Moya
import Result

typealias APIResultComletion<T> = (Result<T>) -> Void
typealias CountryCompletion = APIResultComletion<[CountryModel]>

final class  CountryService {
    static let shared = CountryService()
    private let apiService = MoyaProvider<CountryRouter>()
    
    func getCountry(region: RegionEnum, completion: @escaping CountryCompletion) {
        let request: CountryRouter = .getCountries(CountryCredentials(regionName: region.region, countryName: "", countrysBorderСode: ""))
        apiService.request(request) {
            switch $0 {
            case .success(let moyaResponse):
                do {
                    let countrys = try moyaResponse.map([CountryModel].self)
                    completion( .success(countrys) )
                } catch {
                    completion( .failure(APIError.parsError) )
                }
            case .failure(let error):
                completion( .failure(APIError(error: error)) )
            }
        }
    }
    
    func  getCountryByCode(countryCode: String, completion: @escaping CountryCompletion) {
        let request: CountryRouter = .getCountriesByCode(CountryCredentials(regionName: "", countryName: "", countrysBorderСode: countryCode))
        apiService.request(request) {
            switch $0 {
            case .success(let moyaResponse):
                do {
                    let countrys = try moyaResponse.map([CountryModel].self)
                    completion( .success(countrys) )
                } catch {
                    completion( .failure(APIError.parsError) )
                }
            case .failure(let error):
                completion( .failure(APIError(error: error)) )
            }
        }
    }
    
    func  getCountryByName(countryName: String, completion: @escaping CountryCompletion) {
        let request: CountryRouter = .searchCountries(CountryCredentials(regionName: "", countryName: countryName, countrysBorderСode: ""))
        apiService.request(request) {
            switch $0 {
            case .success(let moyaResponse):
                do {
                    let countrys = try moyaResponse.map([CountryModel].self)
                    completion( .success(countrys) )
                } catch {
                    completion( .failure(APIError.parsError) )
                }
            case .failure(let error):
                completion( .failure(APIError(error: error)) )
            }
        }
    }
}
