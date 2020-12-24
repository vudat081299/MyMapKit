//
//  ViewController.swift
//  MyMapKit
//
//  Created by Vũ Quý Đạt  on 10/12/2020.
//

import UIKit
import MapKit
import CoreLocation

//// MARK: - Statics
//struct UserLocationManager {
//    static var userLocation = CLLocation()
//}

// MARK: - MapView container.
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var takePhotoViewButton: UIButton!
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet weak var userInfoButton: UIButton!
    
    
    // MARK: - Statics
    static var userLocationVal: CLLocation?
    var userLocation: CLLocation? {
        willSet {
            if isJustGetintoApp {
                guard let location = newValue else {
                    return
                }
                let initialLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                mapView.centerToLocation(initialLocation)
                isJustGetintoApp = false
            }
            ViewController.userLocationVal = newValue!
        }
    }
    
    
    // MARK: - Bools
    var isJustGetintoApp = true
    
    
    // MARK: - Consts
    let image = UIImage(named: "camera_icon")?.withRenderingMode(.alwaysTemplate)
    let annotationsRequestInfo = ResourceRequest<AnnotationInfo>(resourcePath: "annotations")
    
    // MARK: - Variables
    var locationManager:CLLocationManager!
    private var artworks: [Annotation] = []
    var passingAnnotationFrom: PassingAnnotationFrom!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUserLocationGetter()
        
//        // Set initial location in Honolulu
//        let initialLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        mapView.centerToLocation(initialLocation)
        
//        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
//        let region = MKCoordinateRegion(
//            center: oahuCenter.coordinate,
//            latitudinalMeters: 50000,
//            longitudinalMeters: 60000)
//        mapView.setCameraBoundary(
//            MKMapView.CameraBoundary(coordinateRegion: region),
//            animated: true)
        
//        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
//        mapView.setCameraZoomRange(zoomRange, animated: true)
        
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isJustGetintoApp = true
        setUpAnnotations()
    }
    
    func setUpAnnotations() {
        mapView?.delegate = self
        
        mapView?.register(
            AnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        loadInitialData()
//        mapView?.addAnnotations(artworks)
    }
    
    func setUpUserLocationGetter() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
    }
    
    // load annotations from file geojson
    private func loadInitialData() {
        getAnnotationList()
        // 1
//        guard
//            let fileName = Bundle.main.url(forResource: "Annotation", withExtension: "geojson"),
//            let artworkData = try? Data(contentsOf: fileName)
//        else {
//            return
//        }
//
//        do {
//            // 2
//            let features = try MKGeoJSONDecoder()
//                .decode(artworkData)
//                .compactMap { $0 as? MKGeoJSONFeature }
//            // 3
//            print(features)
//            print(try MKGeoJSONDecoder()
//                    .decode(artworkData))
//            let validWorks = features.compactMap(Annotation.init)
//            // 4
//            artworks.append(contentsOf: validWorks)
//        } catch {
//            // 5
//            print("Unexpected error: \(error).")
//        }
    }
    
    func getAnnotationList () {
        annotationsRequestInfo.getAllAnnotations { [weak self] result in
            
            switch result {
            case .failure:
//                ErrorPresenter.showError(message: "There was an error getting the annotations", on: self)
                print("fail get image!")
            case .success(let annotationData):
                DispatchQueue.main.async { [weak self] in
                    guard self != nil else { return }
                    // 1
                    let artworkData = annotationData
                    do {
                        // 2
                        let features = try MKGeoJSONDecoder()
                            .decode(artworkData)
                            .compactMap { $0 as? MKGeoJSONFeature }
                        // 3
                        print(features)
                        print(try MKGeoJSONDecoder()
                                .decode(artworkData))
                        let validWorks = features.compactMap(Annotation.init)
                        // 4
                        self!.artworks.append(contentsOf: validWorks)
                        print(self!.artworks.count)
                        self!.mapView?.addAnnotations(self!.artworks)
                    } catch {
                        // 5
                        print("Unexpected error: \(error).")
                    }
                }
            }
        }
    }
    
    func setUpView() {
        takePhotoViewButton.setImage(image, for: .normal)
        takePhotoViewButton.tintColor = .black
        userInfoButton.roundedBorder()
    }
    
    @IBAction func loadinitdata(_ sender: Any) {
        loadInitialData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AnnotatitionViewController
        vc.annoTitle = passingAnnotationFrom.title
        vc.mySubTitle = passingAnnotationFrom.mySubTitle
        vc.annoDescription = passingAnnotationFrom.annoDescription
        vc.discipline = passingAnnotationFrom.discipline
        vc.type = passingAnnotationFrom.type
        vc.imageNote = passingAnnotationFrom.type
        vc.country = passingAnnotationFrom.country
        vc.city = passingAnnotationFrom.city
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        // custom
//        if (control as? UIButton)?.buttonType ==  UIButton.ButtonType.detailDisclosure {
//            mapView.deselectAnnotation(view.annotation, animated: false)
//            return
//        }
        
        guard let artwork = view.annotation as? Annotation else {
            return
        }
        performSegue(withIdentifier: "annotationDetail", sender: self)
        passingAnnotationFrom = PassingAnnotationFrom(title: artwork.title, mySubTitle: artwork.subtitle, annoDescription: artwork.description, discipline: artwork.discipline, type: artwork.type, imageNote: artwork.imageNote, country: artwork.country, city: artwork.city)
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        artwork.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var view: AnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation") as? AnnotationView
//        if view == nil {
//            view = AnnotationView(annotation: annotation, reuseIdentifier: "annotation")
//        }
//        let annotation = annotation as! Annotation
//        view?.image = annotation.image
//        view?.annotation = annotation
//        
//        return view
//    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.showsUserLocation = true
//    }
}

//MARK: - Location delegate methods
extension ViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation :CLLocation = locations[0] as CLLocation
        userLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation!) { (placemarks, error) in
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
//                let placemark = placemarks![0]
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Service Error \(error)")
    }
}

struct PassingAnnotationFrom {
    let title: String?
    let mySubTitle: String?
    let annoDescription: String?
    let discipline: String?
    let type: String?
    let imageNote: String?
    let country: String?
    let city: String?
}
