//
//  CountryCellDelegate.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-13.
//

import Foundation
protocol CountryCellDelegate: AnyObject
{
    func goToCountry(country: CountryModel)
}
