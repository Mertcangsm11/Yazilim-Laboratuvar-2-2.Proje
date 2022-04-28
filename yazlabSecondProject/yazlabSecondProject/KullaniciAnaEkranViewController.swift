//
//  KullaniciAnaEkranViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 31.03.2022.
//

import UIKit
import Foundation
import CoreData
class KullaniciAnaEkranViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    static var durakAdlari = [String]()
    static var idArrray = [UUID]()
    static var durakLatitude = [Double]()
    static var durakLongitude = [Double]()
    var secilenDurak : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Bineceginiz Duragi Seciniz"
        getData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(mapSegue))
    }
    @objc func mapSegue(){
        performSegue(withIdentifier: "KullaniciHaritaSegue", sender: nil)
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Durakk")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                KullaniciAnaEkranViewController.durakAdlari.removeAll(keepingCapacity: false)
                KullaniciAnaEkranViewController.idArrray.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject]{
                    if let durak = result.value(forKey: "durakAdi") as? String{
                        KullaniciAnaEkranViewController.durakAdlari.append(durak)
                    }
                    if let id = result.value(forKey: "idid") as? UUID{
                        KullaniciAnaEkranViewController.idArrray.append(id)
                    }
                    if let latitude = result.value(forKey: "latitude") as? Double{
                        KullaniciAnaEkranViewController.durakLatitude.append(latitude)
                    }
                    if let longitude = result.value(forKey: "longitude") as? Double{
                        KullaniciAnaEkranViewController.durakLongitude.append(longitude)
                    }
                    tableView.reloadData()
                }
            }
            
        }catch{
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = KullaniciAnaEkranViewController.durakAdlari[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KullaniciAnaEkranViewController.durakAdlari.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let uyarı = UIAlertController(title: KullaniciAnaEkranViewController.durakAdlari[indexPath.row], message: "Secilen Duragi Onaylıyor Musunuz?", preferredStyle: UIAlertController.Style.alert)
        let evetButonu = UIAlertAction(title: "EVET", style: UIAlertAction.Style.default) { (UIAlertAction) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let yeniTalep = NSEntityDescription.insertNewObject(forEntityName: "Talepler", into: context)
            yeniTalep.setValue(KullaniciAnaEkranViewController.durakAdlari[indexPath.row], forKey: "talep")
            yeniTalep.setValue(KullaniciGirisViewController.isim, forKey: "kisiAdi")
            yeniTalep.setValue(UUID(), forKey: "idd")
            do{
                try context.save()
                print("Talep Alindi")
            }catch{
                print("Talep Alinamadi")
            }
        }
        let hayırButonu = UIAlertAction(title: "HAYIR", style: UIAlertAction.Style.cancel, handler: nil)
        uyarı.addAction(evetButonu)
        uyarı.addAction(hayırButonu)
        self.present(uyarı,animated: true)
    }
    

}
