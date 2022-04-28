//
//  YoneticiGirisViewController.swift
//  yazlabSecondProject
//
//  Created by Sinan on 27.03.2022.
//

import UIKit

class YoneticiGirisViewController: UIViewController {

    @IBOutlet weak var KullaniciAdiText: UITextField!
    @IBOutlet weak var SifreText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GirisYpaTıkla(_ sender: Any) {
        if KullaniciAdiText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Kullanici adi giriniz.")
        }else if SifreText.text == ""{
            uyarıGöster(baslık: "HATA!!!", mesaj: "Sifre Giriniz.")
        }else if KullaniciAdiText.text == "admin" && SifreText.text == "admin"{
            performSegue(withIdentifier: "YoneticiDigerSegue", sender: nil)
        }else {
            uyarıGöster(baslık: "HATA!!!", mesaj: "Giris Yapilamadi.")
        }
    }
    
    func uyarıGöster(baslık:String,mesaj:String){
        let uyarı = UIAlertController(title: baslık, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        let TamamButonu = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        uyarı.addAction(TamamButonu)
        self.present(uyarı,animated: true)
    }

}
