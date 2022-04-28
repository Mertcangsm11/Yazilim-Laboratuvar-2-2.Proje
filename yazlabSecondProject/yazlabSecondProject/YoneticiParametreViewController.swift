//
//  YoneticiParametreViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 4.04.2022.
//

import UIKit
import CoreData
class YoneticiParametreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var kiralikTutarText: UITextField!
    @IBOutlet weak var tutarSayi: UITextField!
    @IBOutlet weak var izmitSayi: UITextField!
    @IBOutlet weak var korfezSayi: UITextField!
    @IBOutlet weak var kartepeSayi: UITextField!
    @IBOutlet weak var karamürselSayi: UITextField!
    @IBOutlet weak var kandiraSayi: UITextField!
    @IBOutlet weak var golcukSayi: UITextField!
    @IBOutlet weak var gebzeSayi: UITextField!
    @IBOutlet weak var dilovasiSayi: UITextField!
    @IBOutlet weak var derinceSayi: UITextField!
    @IBOutlet weak var daricaSayi: UITextField!
    @IBOutlet weak var cayirovaSayi: UITextField!
    @IBOutlet weak var basiskeleSayi: UITextField!
    static var kiralikTutar = 50
    var talepliler = [String]()
    var talepler = [String]()
    var idDizi = [UUID]()
    static var yirmibeslik = 0
    static var otuzluk = 0
    static var kirklik = 0
    static var maliyetkm = 0
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        getData()
    }
    
    @IBAction func parametreOnayButonu(_ sender: Any) {
        
        YoneticiParametreViewController.yirmibeslik = 0
        YoneticiParametreViewController.kirklik = 0
        YoneticiParametreViewController.otuzluk = 0
        YoneticiParametreViewController.maliyetkm = Int(tutarSayi.text!)!
        YoneticiParametreViewController.kiralikTutar = Int(kiralikTutarText.text!)!
        var toplam : Float = Float(basiskeleSayi.text!)!+Float(cayirovaSayi.text!)!+Float(daricaSayi.text!)!+Float(derinceSayi.text!)!+Float(dilovasiSayi.text!)!+Float(gebzeSayi.text!)!+Float(golcukSayi.text!)!+Float(kandiraSayi.text!)!+Float(karamürselSayi.text!)!+Float(kartepeSayi.text!)!+Float(korfezSayi.text!)!+Float(izmitSayi.text!)!
        var gebzeToplam :Float
        gebzeToplam = Float(daricaSayi.text!)!+Float(cayirovaSayi.text!)!+Float(gebzeSayi.text!)!+Float(dilovasiSayi.text!)!+Float(derinceSayi.text!)!+Float(korfezSayi.text!)!+Float(kandiraSayi.text!)!+Float(izmitSayi.text!)!
        var gölcükToplam :Float
        gölcükToplam = Float(karamürselSayi.text!)!+Float(golcukSayi.text!)!+Float(basiskeleSayi.text!)!+Float(kartepeSayi.text!)!
        if toplam > 95{
            var a = Int((toplam-95))/25
            var b = Int((toplam-95))%25
            if b != 0{
                YoneticiParametreViewController.yirmibeslik+=Int(a+2)
                YoneticiParametreViewController.kirklik=1
                YoneticiParametreViewController.otuzluk=1
            }else{
                YoneticiParametreViewController.yirmibeslik+=Int(a+1)
                YoneticiParametreViewController.kirklik=1
                YoneticiParametreViewController.otuzluk=1
            }
            
        }else{
            if toplam > 25{
                if toplam > 30{
                    if toplam > 40{
                        if toplam > 40 && toplam <= 55{
                            YoneticiParametreViewController.yirmibeslik+=1
                            YoneticiParametreViewController.otuzluk=1
                        }else if toplam > 55 && toplam <= 70{
                            YoneticiParametreViewController.kirklik=1
                            YoneticiParametreViewController.otuzluk=1
                        }else if toplam>70 && toplam <= 95{
                            YoneticiParametreViewController.yirmibeslik+=1
                            YoneticiParametreViewController.otuzluk=1
                            YoneticiParametreViewController.kirklik=1
                        }
                    }else if toplam > 30 && toplam <= 40{
                        YoneticiParametreViewController.kirklik=1
                    }
                }else if toplam > 25 && toplam <= 30{
                    YoneticiParametreViewController.otuzluk=1
                }
            }else {
                YoneticiParametreViewController.yirmibeslik+=1
            }
        }
        performSegue(withIdentifier: "YmapSegue", sender: nil)
        
    }
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Talepler")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0{
                self.talepler.removeAll(keepingCapacity: false)
                self.talepliler.removeAll(keepingCapacity: false)
                for result in results as! [NSManagedObject]{
                    if let durak = result.value(forKey: "talep") as? String{
                        self.talepler.append(durak)
                    }
                    if let id = result.value(forKey: "idd") as? UUID{
                        self.idDizi.append(id)
                    }
                    if let talepli = result.value(forKey: "kisiAdi") as? String{
                        self.talepliler.append(talepli)
                    }
                    TableView.reloadData()
                }
            }
            
        }catch{
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(talepliler[indexPath.row]) - \(talepler[indexPath.row])"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talepliler.count
    }
    
    
    @IBAction func TalepButonu(_ sender: Any) {
        KullaniciHaritaViewController.onay = "Onaylandi"
        let uyarı = UIAlertController(title: "ONAYLANDI", message: "Duraklar Onaylanmıştır.", preferredStyle: UIAlertController.Style.alert)
        let tamamButon = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.cancel, handler: nil)
        uyarı.addAction(tamamButon)
        self.present(uyarı, animated: true)
        
    }
    
}
