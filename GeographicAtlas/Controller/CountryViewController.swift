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
    func onCountryModelDidUpdate(with model: [CountryModel]) {
        navigation.title = model[0].name.common
        if let subregion = model[0].subregion {
            regionLabel.text = subregion
        }
        capitalLabel.text = model[0].capital?[0]

        if let latitude = model[0].capitalInfo?.latlng?[0], let longtitude = model[0].capitalInfo?.latlng?[1] {
            coordinatesLabel.text = "\(latitude), \(longtitude)"
            coordinatesLabel.isUserInteractionEnabled = true
            coordinatesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        }
        
        if let url = model[0].maps.openStreetMaps {
            mapURL = url
        }
        
        if let url = URL(string: model[0].flags.png) {
            let resource = ImageResource(downloadURL: url)
            flagImage.kf.setImage(with: resource)
        }
        populationLabel.text = String(model[0].population)
        if let area = model[0].area {
            areaLabel.text = String(area)
        }
        if let currencies = model[0].currencies {
            for (key, value) in currencies {
                currencyLabel.text = "\(value.name) (\(value.symbol ?? "NS")) (\(key))"

            }
        }
        for time in model[0].timezones {
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

