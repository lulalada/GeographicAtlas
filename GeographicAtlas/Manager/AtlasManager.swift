//
//  AtlasManager.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-12.
//

import Foundation
import Alamofire

protocol AtlasManagerDelegate: AnyObject {
    func onCountryModelsDidUpdate(with models: [CountryModel])
}

struct AtlasManager {
    
    weak var delegate: AtlasManagerDelegate?
    
    func fetchCountries(){
        let urlString = "https://restcountries.com/v3.1/all"

        AF.request(urlString).responseDecodable(of: [CountryModel].self) { response in
            switch response.result {
            case .success(let models):
                delegate?.onCountryModelsDidUpdate(with: models)
            case .failure(let error):
                print(error)
            }
        }

    }
}
