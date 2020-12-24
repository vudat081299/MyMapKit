//
//  Upload.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 12/12/2020.
//

import Foundation
import CoreLocation

final class AnnotationA: Codable {
    var annotationImageName: String
    var image: String
    
    init(annotationImageName: String, image: String) {
        self.annotationImageName = annotationImageName
        self.image = image
    }
}

final class AnnotationUpload: Codable {
    var title: String
    var subTitle: String
    var latitude: String
    var longitude: String
    var description: String
    var image: [File]
    var type = TypeAnnotation.publibPlace.rawValue
    var imageNote: [String]
    
    init(title: String, subTitle: String, latitude: String, longitude: String, description: String, imageNote: [String], image: [File]) {
        self.title = title
        self.subTitle = subTitle
        self.latitude = latitude
        self.longitude = longitude
        self.description = description
        self.imageNote = imageNote
        self.image = image
        
    }
    
    var country: String? {
        get {
            getPlaceInfo()[0]
        }
    }
    var city: String? {
        get {
            getPlaceInfo()[0]
        }
    }
    func getPlaceInfo() -> [String] {
        var place = ["", "", ""]
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(ViewController.userLocationVal) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode - can not get location of device!")
            }
            var placemark: [CLPlacemark]!
            if placemarks != nil {
                placemark = placemarks! as [CLPlacemark]
            } else {
                print("loading location..")
                return
            }
            if placemark.count > 0 {
                let placemark = placemarks![0]
                place[0] = placemark.locality!
                place[1] = placemark.administrativeArea!
                place[2] = placemark.country!
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
            }
        }
        return place
    }
}

final class AnnotationInfo: Codable {
    var id: Int
    var latitude: String
    var longitude: String
    var name: String
    var description: String
    
    init(id: Int, latitude: String, longitude: String, name: String, description: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.description = description
    }
}

final class CheckTotalOfAnnotationsReponse: Codable {
    var shouldUpdate: Bool
    init(shouldUpdate: Bool) {
        self.shouldUpdate = shouldUpdate
    }
}

final class CreateUserFormData: Codable {
    var id: UUID?
    var name: String
    var username: String
    var password: String?
    var email: String
    var phonenumber: String
    
    init(name: String, username: String, password: String, email: String, phonenumber: String) {
        self.name = name
        self.username = username
        self.password = password
        self.email = email
        self.phonenumber = phonenumber
    }
}
