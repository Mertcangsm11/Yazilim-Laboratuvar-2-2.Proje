//
//  YoneticiAnaEkranViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 31.03.2022.
//

import UIKit
import CoreData
import MapKit
import CoreLocation
class YoneticiAnaEkranViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    
    @IBOutlet weak var durakMap: MKMapView!
    @IBOutlet weak var textField: UITextField!
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecogniser:)))
        gestureRecogniser.minimumPressDuration = 3
        durakMap.addGestureRecognizer(gestureRecogniser)
        
    }
    
    
    @objc func chooseLocation(gestureRecogniser: UILongPressGestureRecognizer){
        if gestureRecogniser.state == .began{
            let touchedPoint = gestureRecogniser.location(in: self.durakMap)
            let touchedCoordinates = self.durakMap.convert(touchedPoint, toCoordinateFrom: self.durakMap)
            choosenLatitude = touchedCoordinates.latitude
            choosenLongitude = touchedCoordinates.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = "Yeni Durak Konumu"
            annotation.subtitle = "Eklemek icin butona basınız!"
            self.durakMap.addAnnotation(annotation)
        }
    }
    
    @IBAction func ParametreButonu(_ sender: Any) {
        performSegue(withIdentifier: "ParametreSegue", sender: nil)
    }
    @IBAction func durakEkleButonu(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let yeniDurak = NSEntityDescription.insertNewObject(forEntityName: "Durakk", into: context)
        yeniDurak.setValue(textField.text!, forKey: "durakAdi")
        yeniDurak.setValue(choosenLatitude, forKey: "latitude")
        yeniDurak.setValue(choosenLongitude, forKey: "longitude")
        yeniDurak.setValue(UUID(), forKey: "idid")
        do{
            try context.save()
            uyarıGöster(baslik: "Durak Eklendi...", mesaj: "Geri Dönebilirsiniz.")
        }catch{
            uyarıGöster(baslik: "Durak Eklenemedi!!!", mesaj: "Tekrar denemek için butona basınız.")
        }
        
        
    }
    func uyarıGöster(baslik:String,mesaj:String){
        let uyarı = UIAlertController(title: baslik, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        if baslik == "Durak Eklendi..."{
            let TamamButonu = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default) { (UIAlertAction) in
            }
            uyarı.addAction(TamamButonu)
            self.present(uyarı, animated: true)
        }else{
            let TekrarButonu = UIAlertAction(title: "Tekrar Deneyiniz...", style: UIAlertAction.Style.default, handler: nil)
            uyarı.addAction(TekrarButonu)
            self.present(uyarı,animated: true)
        }
        
    }

}
