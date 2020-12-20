//
//  UploadAnnotationViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 20/12/2020.
//

import UIKit
import CoreLocation

enum TypeAnnotation: Int, CaseIterable {
    case restaurant, coffeShop, clothesShop, pharmacy, superMaket
}

let typeAnnotationText = ["Restaurant", "Coffe Shop", "Clothes Shop", "Pharmacy", "Super Maket"]

struct UploadAnnotationData {
    var title = "Loading title"
    var subTitle = ""
    var description = ""
    var type: TypeAnnotation?
    var imageNote: [String]?
    var image: [File]?
    
    var lat: CLLocationDegrees {
        get {
            return ViewController.userLocationVal.coordinate.latitude
        }
    }
    var long: CLLocationDegrees {
        get {
            return ViewController.userLocationVal.coordinate.longitude
        }
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

let uploadAnnotationData = UploadAnnotationData()

class UploadAnnotationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var csBottomTableView: NSLayoutConstraint!
    
    var listCapturedImage: [UIImage]?
    
    var inputFieldText = ["Location name", "Note", "Description"]
    var placeholderInputFieldText = ["Ha noi ..v", "address or something special", "your review"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            let cell = UITableViewCell()

            
            let uploadView: ImageAnnotation = ImageAnnotation(nibName: "ImageAnnotation", bundle: nil)
            uploadView.imageArray = listCapturedImage
            cell.contentView.addSubview(uploadView.view)
            return cell
        } else {
            let cell: UploadAnnoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UploadAnnoTableViewCell", for: indexPath) as! UploadAnnoTableViewCell
            cell.indexPath = indexPath
            cell.title.text = inputFieldText[indexPath.row]
            cell.textInput.placeholder = placeholderInputFieldText[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Information about this place"
        } else {
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.inputTableView.register(UINib(nibName: "UploadAnnoTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadAnnoTableViewCell")
        self.inputTableView.register(UINib(nibName: "UITableViewCell", bundle: nil), forCellReuseIdentifier: "UITableViewCell")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 150
        }
        return 60
    }

    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
