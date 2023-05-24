//
//  Customer.swift
//  ShopSubscription
//
//  Created by Alua Sayabayeva on 2023-05-23.
//

import Foundation
struct Customer {
    var name: String
    var phoneNumber: String
    var city: String
    var street: String
    var entranceNumber: String
    var apartmentNumber: String
    var floorNumber: String
    var day: String
    var time: String
    var period: String
    
    init(name: String = "", phoneNumber: String = "", city: String = "", street: String = "", entranceNumber: String = "", apartmentNumber: String = "", floorNumber: String = "", day: String = "", time: String = "", period: String = "") {
        self.name = name
        self.phoneNumber = phoneNumber
        self.city = city
        self.street = street
        self.entranceNumber = entranceNumber
        self.apartmentNumber = apartmentNumber
        self.floorNumber = floorNumber
        self.day = day
        self.time = time
        self.period = period
    }
    
}
