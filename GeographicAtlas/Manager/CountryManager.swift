//
//  CountryManager.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-13.
//

import Foundation
import Alamofire

protocol CountryManagerDelegate: AnyObject {
    func onCountryModelDidUpdate(with model: CountryModel)
}

struct CountryManager {
    
    weak var delegate: CountryManagerDelegate?
    
    func fetchCountry(with cca2: String) {
        let urlString = "https://restcountries.com/v3.1/alpha/\(cca2)"
        
        AF.request(urlString).responseDecodable(of: [CountryModel].self) { response in
            switch response.result {
            case .success(let model):
                
                delegate?.onCountryModelDidUpdate(with: model[0])
            case .failure(let error):
                print(error)
            }
        }
    }
}
