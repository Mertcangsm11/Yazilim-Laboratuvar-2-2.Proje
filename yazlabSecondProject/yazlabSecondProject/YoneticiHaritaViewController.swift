//
//  YoneticiHaritaViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 4.04.2022.
//

import UIKit
import MapKit
import CoreData
class YoneticiHaritaViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var toplamMaliyet: UITextField!
    @IBOutlet weak var aracMaliyet: UITextField!
    @IBOutlet weak var maliyetText: UITextField!
    @IBOutlet weak var kiralıkKutu: UITextField!
    @IBOutlet weak var yirmiBesKutu: UITextField!
    @IBOutlet weak var otuzKutu: UITextField!
    @IBOutlet weak var kirkKutu: UITextField!
    var kiralik = 0
    var durakDizi = [String]()
    var durakLatitude = [Double]()
    var durakLongitude = [Double]()
    var durakId = [UUID]()
    @IBOutlet weak var YmapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        YmapView.delegate = self
        getData()
        setupmm()
        setupm()
        yirmiBesKutu.text = String(YoneticiParametreViewController.yirmibeslik)
        otuzKutu.text = String(YoneticiParametreViewController.otuzluk)
        kirkKutu.text = String(YoneticiParametreViewController.kirklik)
        kiralik = (YoneticiParametreViewController.yirmibeslik - 1)
        if kiralik < 0 {
            kiralıkKutu.text = "0"
            aracMaliyet.text = "0"
        }else{
            kiralıkKutu.text = String(YoneticiParametreViewController.yirmibeslik - 1)
            aracMaliyet.text = String((YoneticiParametreViewController.yirmibeslik - 1)*YoneticiParametreViewController.kiralikTutar)
        }
        maliyetText.text = String(YoneticiParametreViewController.maliyetkm * 215)
        toplamMaliyet.text = String(Int(maliyetText.text!)! + Int(aracMaliyet.text!)!)
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Durakk")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                self.durakDizi.removeAll(keepingCapacity: false)
                self.durakLatitude.removeAll(keepingCapacity: false)
                self.durakLongitude.removeAll(keepingCapacity: false)
                self.durakId.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject]{
                    if let durak = result.value(forKey: "durakAdi") as? String{
                        self.durakDizi.append(durak)
                    }
                    if let id = result.value(forKey: "idid") as? UUID{
                        self.durakId.append(id)
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double{
                        self.durakLatitude.append(latitude)
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double{
                        self.durakLongitude.append(longitude)
                    }
                    
                }
            }
            for i in 0..<durakDizi.count{
                let annotation = MKPointAnnotation()
                let coordinate = CLLocationCoordinate2D(latitude: durakLatitude[i], longitude: durakLongitude[i])
                annotation.title = durakDizi[i]
                annotation.subtitle = " "
                annotation.coordinate = coordinate
                self.YmapView.addAnnotation(annotation)
            }
            
        }catch{
            
        }
        
    }
    func setupmm() {
            
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.7999, longitude: 29.4166)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.8223, longitude: 29.9243)
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.title = "Cayirova Duragi"
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.title = "Umuttepe Duragi"
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
                
            }
            
            
            YmapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            
        let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate { (response, error) in
                if error != nil {
                    return
                }
                
                let route = response?.routes[0]
                self.YmapView.addOverlay((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
                
                let rect = route?.polyline.boundingMapRect
                self.YmapView.setRegion(MKCoordinateRegion(rect!), animated: true)
                
                print("\((route?.expectedTravelTime)! / 60) minute walking distance")
            }
            
            
        }
    func setupm() {
            
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.69144 , longitude: 29.61568)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.8223, longitude: 29.9243)
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            let sourceAnnotation = MKPointAnnotation()
            sourceAnnotation.title = "Karamürsel Duragi"
            
            if let location = sourcePlacemark.location {
                sourceAnnotation.coordinate = location.coordinate
            }
            
            let destinationAnnotation = MKPointAnnotation()
            destinationAnnotation.title = "Umuttepe Duragi"
            
            if let location = destinationPlacemark.location {
                destinationAnnotation.coordinate = location.coordinate
                
            }
            
            
            YmapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
            
            
        let directionRequest = MKDirections.Request()
            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            
            directions.calculate { (response, error) in
                if error != nil {
                    return
                }
                
                let route = response?.routes[0]
                self.YmapView.addOverlay((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
                
                let rect = route?.polyline.boundingMapRect
                self.YmapView.setRegion(MKCoordinateRegion(rect!), animated: true)
                
                print("\((route?.expectedTravelTime)! / 60) minute walking distance")
            }
            
            
        }
    func mapView(_  mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = UIColor.green
                renderer.lineWidth = 4.0
                
                
                return renderer
    }

}
