//
//  CountryViewController.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-13.
//

import UIKit
import Kingfisher

class CountryViewController: UIViewController {
    
    
    var manager = CountryManager()
    var mapURL = String()
    var cca2 = String()
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stack.showSkeleton()
        
        manager.delegate = self
        manager.fetchCountry(with: cca2)
        flagImage.layer.cornerRadius = 8

    }
  
}

//MARK: - CountryManagerDelegate extension

extension CountryViewController: CountryManagerDelegate {
    func onCountryModelDidUpdate(with model: CountryModel) {
        navigation.title = model.name.common
        if let subregion = model.subregion {
            regionLabel.text = subregion
        }
        if let capital = model.capital?[0] {
            capitalLabel.text = capital
        }

        if let latitude = model.capitalInfo?.latlng?[0], let longtitude = model.capitalInfo?.latlng?[1] {
            coordinatesLabel.text = "\(latitude), \(longtitude)"
            coordinatesLabel.isUserInteractionEnabled = true
            coordinatesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        }
        
        if let url = model.maps.openStreetMaps {
            mapURL = url
        }
        
        if let url = URL(string: model.flags.png) {
            let resource = ImageResource(downloadURL: url)
            flagImage.kf.setImage(with: resource)
        }
        populationLabel.text = String(model.population)
        if let area = model.area {
            areaLabel.text = String(area)
        }
        if let currencies = model.currencies {
            for (key, value) in currencies {
                currencyLabel.text = "\(value.name) (\(value.symbol ?? "NS")) (\(key))"

            }
        }
        for time in model.timezones {
            timezoneLabel.text?.append("\(time) ")
        }
        stack.hideSkeleton()
        
    }
    
    @objc func labelTapped() {
        if let url = URL(string: mapURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

