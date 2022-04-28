//
//  KullaniciGirisViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 27.03.2022.
//

import UIKit
import CoreData

class KullaniciGirisViewController: UIViewController {

    static var isim = " "
    @IBOutlet weak var KullaniciAdiText: UITextField!
    @IBOutlet weak var SifreText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GirisYapTikla(_ sender: Any) {
        if KullaniciAdiText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Kullanici adi giriniz.")
        }else if SifreText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Sifre Giriniz.")
        }else{
           dataSorgula()
        }
    }
    
    func dataSorgula(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kullanici")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            var kontrol = 0
            for result in results as! [NSManagedObject]{
                if KullaniciAdiText.text == result.value(forKey: "name") as! String && SifreText.text == result.value(forKey: "password") as! String{
                    kontrol = 1
                    
                }
            }
            if kontrol == 1{
                performSegue(withIdentifier: "KullaniciIkiSegue", sender: nil)
                KullaniciGirisViewController.isim = KullaniciAdiText.text!
            }else{
                uyarıGöster(baslık: "HATA!!!", mesaj: "Bilgileriniz Hatalı")
            }
            
        }catch{
            uyarıGöster(baslık: "HATA!!!", mesaj: "catch hatası")
        }
    }
    
    func uyarıGöster(baslık:String,mesaj:String){
        let uyarı = UIAlertController(title: baslık, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        let TamamButonu = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        uyarı.addAction(TamamButonu)
        self.present(uyarı,animated: true)
    }

}
