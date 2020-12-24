//
//  UploadAnnotationViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 20/12/2020.
//

import UIKit
import CoreLocation

enum TypeAnnotation: Int, CaseIterable {
    case publibPlace, restaurant, coffeShop, clothesShop, pharmacy, superMaket
}

let typeAnnotationText = ["Public place", "Restaurant", "Coffe Shop", "Clothes Shop", "Pharmacy", "Super Maket"]

struct UploadAnnotationData {
    var title = "a"
    var subTitle = "a"
    var description = "a"
    var type: TypeAnnotation?
    var imageNote: [String]? = ["a"]
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

var uploadAnnotationData = UploadAnnotationData()

class UploadAnnotationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet weak var inputTableView: UITableView!
    @IBOutlet weak var csBottomTableView: NSLayoutConstraint!
    
    var listCapturedImage: [UIImage]?
    
    var inputFieldText = ["Location name", "Note", "Description"]
    var placeholderInputFieldText = ["Ha Noi ..v", "address or something special", "your review"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return listCapturedImage!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: UploadAnnoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UploadAnnoTableViewCell", for: indexPath) as! UploadAnnoTableViewCell
            cell.indexPath = indexPath
            cell.title.text = inputFieldText[indexPath.row]
            cell.textInput.placeholder = placeholderInputFieldText[indexPath.row]
            return cell
        } else if indexPath.section == 1 {
            let cell: ViewImageCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ViewImageCellTableViewCell", for: indexPath) as! ViewImageCellTableViewCell
            
            cell.imageAnno.image = listCapturedImage![indexPath.row]
            cell.imageAnno.border()
            cell.layerImageView.dropShadow()
            cell.textInput.placeholder = "Enter your review"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Information about this place"
        } else if section == 1 {
            return "Review for every pictures you did take"
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadAnnotationData = UploadAnnotationData()

        // Do any additional setup after loading the view.
        self.inputTableView.register(UINib(nibName: "UploadAnnoTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadAnnoTableViewCell")
        self.inputTableView.register(UINib(nibName: "ViewImageCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewImageCellTableViewCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return 150
        }
        return 60
    }

    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func uploadAnnotationToServer(_ sender: UIButton) {
        var file = [File] ()
        for (index, value) in listCapturedImage!.enumerated() {
            file.append(File(data: value.pngData()!, filename: "\(index)"))
        }
        let user = AnnotationUpload(title: uploadAnnotationData.title, subTitle: uploadAnnotationData.subTitle, latitude: String(ViewController.userLocationVal.coordinate.latitude), longitude: String(ViewController.userLocationVal.coordinate.longitude), description: uploadAnnotationData.description, imageNote: uploadAnnotationData.imageNote!, image: file)
        ResourceRequest<AnnotationUpload>(resourcePath: "annotations").save(user) { [weak self] result in
            switch result {
            case .failure:
                print("upload fail")
            case .success:
                DispatchQueue.main.async { [weak self] in
                    print("successful created annotation!")
                }
            }
        }
        
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

//MARK: Keyboard.
extension UploadAnnotationViewController: UITextFieldDelegate {
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardRect.height
            UIView.animate(withDuration: 0.3,
                           delay: 0.1,
                           options: [.curveEaseIn],
                           animations: { [weak self] in
                            self?.csBottomTableView.constant = self!.keyboardHeight
                           }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.1,
                       options: [.curveEaseIn],
                       animations: { [weak self] in
                        self?.csBottomTableView.constant = 0
                       }, completion: nil)
        view.layoutIfNeeded()
//            if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//                UIView.animate(withDuration: 0.3,
//                               delay: 0.1,
//                               options: [.curveEaseIn],
//                               animations: { [weak self] in
//                               }, completion: nil)
    }
}

