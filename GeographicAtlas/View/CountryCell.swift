//
//  CountryCell.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-12.
//

import UIKit
import Kingfisher

class CountryCell: UITableViewCell {
    
    weak var delegate:CountryCellDelegate?
    var country: CountryModel!

    @IBOutlet weak var dropDown: UIImageView!
    @IBOutlet weak var view: UIStackView!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 15
        flagImage.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configureCell(countryForCell: CountryModel) {
        country = countryForCell
        
        if country.population > 1000000 {
            populationLabel.text = "\(country.population/1000000) mln"
        } else {
            populationLabel.text = String(country.population)
        }
        
        
        if let area = country.area {
            if area >= 1000000 {
                areaLabel.text = "\(area/1000000) mln km²"
            } else {
                areaLabel.text = "\(area) km²"
            }
        }
        
        if let url = URL(string: country.flags.png) {
            let resource = ImageResource(downloadURL: url)
            flagImage.kf.setImage(with: resource)
        }
        dropDown.image = UIImage(named: "edit")
        countryName.text = country.name.common
        
        if let capital = country.capital?[0] {
            capitalName.text = capital
        }
        
        if let currencies = country.currencies {
            for (key, value) in currencies {
                currencyLabel.text = "\(value.name) (\(value.symbol ?? "NS")) (\(key))"

            }
        }
    }
    
    @IBAction func learnMoreTapped(_ sender: UIButton) {
        delegate?.goToCountry(country: country)
    }
    
}


