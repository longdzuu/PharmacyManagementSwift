//
//  AddMedicinViewController.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 21/5/24.
//

import UIKit

class AddMedicinViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var manu: UITextField!
    @IBOutlet weak var expi: UITextField!
    @IBOutlet weak var quality: UITextField!
    @IBOutlet weak var usage: UITextField!
    @IBOutlet weak var unit: UITextField!
    @IBOutlet weak var price: UITextField!
    private let dao = Database()
    var medicin: Drug?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addMecilin(_ sender: Any) {
        let MecilinName = name.text ?? ""
        let MecilinManu = manu.text ?? ""
        let MecilinExpi = expi.text ?? ""
        let MecilinQualiti = quality.text ?? ""
        let MecilinUsage = usage.text ?? ""
        let MecilinUnit =  unit.text ?? ""
        let MecilinPrice = price.text ?? ""
        guard let image = image.image, let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let imageBase64 = imageData.base64EncodedString()
        var success = false
        
        success =  dao.insertDrug(name: MecilinName, producer: MecilinManu, image: imageBase64, hsd: MecilinExpi, uses: MecilinUsage, quantity: MecilinQualiti, unit: MecilinUnit, price: MecilinPrice)
       
        if(success){
            dismiss(animated: true, completion: nil)
        }
        else{
            UIAlertController(title: "", message: "Không thành công", preferredStyle: .alert)
        }
    }
    @IBAction func ImagePicker(_ sender: UITapGestureRecognizer) {
        name.resignFirstResponder()
        //Khai bao doi tuong imagepickerController
        let imagePicker = UIImagePickerController()
        //Cau hinh cho no
        imagePicker.sourceType = .photoLibrary
        //2*2
        //thuc hien uy quyen cho doi tuong imagepicker
        imagePicker.delegate = self
        present(imagePicker, animated:true)
    }
    
    //MARK: Dinh nghia ham uy quyen imagepickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let images = info[.originalImage]{
            image.image = images as? UIImage
        }
        //quay lai man hinh truoc
        dismiss(animated: true)
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
}
