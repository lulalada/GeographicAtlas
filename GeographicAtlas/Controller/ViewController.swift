//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Alua Sayabayeva on 2023-05-12.
//

import UIKit
import Alamofire
import SkeletonView
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var manager = AtlasManager()
    let notificationCenter = UNUserNotificationCenter.current()

    var selectedRow: Int?
    var selectedSection: Int?
    var cca2 = String()
    var groupedCountries: [[CountryModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.delegate = self
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 90
        table.isSkeletonable = true
        table.showAnimatedGradientSkeleton()
        table.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        manager.delegate = self
        manager.fetchCountries()
        
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource extensions
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedCountries.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .gray
        lbl.text = groupedCountries[section][0].continents[0].uppercased()
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedCountries[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CountryCell
        cell.delegate = self
        cell.configureCell(countryForCell: groupedCountries[indexPath.section][indexPath.row] )
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedRow == indexPath.row  && selectedSection == indexPath.section {
            
            return 260
        } else {
            return 90
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.reloadData()
        let cell = tableView.cellForRow(at: indexPath) as! CountryCell
        
        if selectedRow == indexPath.row && selectedSection == indexPath.section {
            selectedRow = nil
            selectedSection = nil
            cell.dropDown.image = UIImage(named: "edit")
        } else {
            selectedRow = indexPath.row
            selectedSection = indexPath.section
            cell.dropDown.image = UIImage(named: "edit2")
        }
        table.beginUpdates()
        table.endUpdates()
    }
}



//MARK: - AtlasManagerDelegate extension

extension ViewController: AtlasManagerDelegate {
    func onCountryModelsDidUpdate(with models: [CountryModel]) {
        for model in models {
            let continentName = model.continents[0]

            if let index = groupedCountries.firstIndex(where: { $0.first?.continents[0] == continentName }) {
                groupedCountries[index].append(model)
            } else {
                groupedCountries.append([model])
            }
        }
        checkForPermission()
        table.reloadData()
        table.hideSkeleton()
    }
}



//MARK: - CountryCellDelegate extension

extension ViewController: CountryCellDelegate {
    func goToCountry(country: CountryModel) {
        cca2 = country.cca2
        performSegue(withIdentifier: "goToCountry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination
          as? CountryViewController else {return}
        secondVC.cca2 = cca2

    }
}

extension ViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "ReusableCell"
    }
    
}


//MARK: - UNUserNotificationCenterDelegate extension

extension ViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let countryViewController = storyboard.instantiateViewController(withIdentifier: "CountryViewControllerID") as? CountryViewController {
            countryViewController.cca2 = cca2
            navigationController?.pushViewController(countryViewController, animated: true)
        }
        
        completionHandler()
    }

    func checkForPermission() {
        
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispathNotification()
            case .denied:
                return
            case .notDetermined:
                self.notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispathNotification()
                    }
                }
            default:
                return
            }
        }
    }

    func dispathNotification() {
        
        let date = Date().addingTimeInterval(5)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
        let i = Int.random(in: 0...6)
        let j = Int.random(in: 0...10)
        let identifier = UUID().uuidString
        let title = "Fun Fact"
        let body = "Did you know that the population of \(groupedCountries[i][j].name.common) is \(groupedCountries[i][j].population) people?"
        cca2 = groupedCountries[i][j].cca2
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request) { (error) in
            
        }
    }
}
