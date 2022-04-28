//
//  KayitOlViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 27.03.2022.
//

import UIKit
import CoreData

class KayitOlViewController: UIViewController {

    @IBOutlet weak var SifreText: UITextField!
    @IBOutlet weak var KullaniciAdiText: UITextField!
    @IBOutlet weak var SifreTekrarText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func KayıtOlTıkla(_ sender: Any) {
        if KullaniciAdiText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Kullanici adi giriniz.")
        }else if SifreText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Sifre Giriniz.")
        }else if SifreText.text != SifreTekrarText.text{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Sifreler eslesemedi!")
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Kullanici", into: context)
            
            newUser.setValue(KullaniciAdiText.text, forKey: "name")
            newUser.setValue(SifreText.text, forKey: "password")
            newUser.setValue(UUID(), forKey: "id")
            do{
                try context.save()
                uyarıGöster(baslık: "Kayıt Oldunuz", mesaj: "Lütfen Giriş Yapınız.")
            }
            catch{
                uyarıGöster(baslık: "Kayıt Basarısız", mesaj: "Lütfen Tekrar Deneyiniz.")
            }        }
            
    }
    
    func uyarıGöster(baslık:String,mesaj:String){
        let uyarı = UIAlertController(title: baslık, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        
        if baslık == "Kayıt Oldunuz"{
            let GeriButonu = UIAlertAction(title: "GERI DON", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.performSegue(withIdentifier: "KayitGeriSegue", sender: nil)
            }
            uyarı.addAction(GeriButonu)
            self.present(uyarı, animated: true)
        }else{
            let TamamButonu = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            uyarı.addAction(TamamButonu)
            self.present(uyarı,animated: true)
        }
        
    }
    

}
