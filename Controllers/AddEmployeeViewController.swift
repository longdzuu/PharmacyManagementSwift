//
//  AddEmployeeViewController.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 23/5/24.
//

import UIKit

class AddEmployeeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let positons = ["Quản lý", "Nhân viên"]
    private let dao = Database()
    private var selectedPosition:String?
    var employee:Employee?
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var radWoman: UIButton!
    @IBOutlet weak var radMan: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var dob: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let positionPickerView = UIPickerView()
        positionPickerView.delegate = self
        positionPickerView.dataSource = self
        positionPickerView.frame = CGRect(x: 8, y: 685, width: 200, height: 50)
        view.addSubview(positionPickerView)
        
        //mac dinh nut rad la checked
        radMan.isSelected = true
        
        //thuc hien uy quyen cho doi tuong TextField
        name.delegate = self
        //lay du lieu truyen sang tu man hinh TableView
        if let employee = employee{
            navbar.title = "Mã NV: " + employee.id
            name.text = employee.name
            employeeImage.image = employee.image
            dob.text = employee.dayOfBirth
            phone.text = employee.phone
            address.text = employee.address
            if(employee.gender == "Nam"){
                radMan.isSelected = true
                radWoman.isSelected = false
            }
            else{
                radWoman.isSelected = true
                radMan.isSelected = false
            }
            if(employee.position == "Nhân viên"){
                positionPickerView.selectRow(1, inComponent: 0, animated: false)
            }
            else{
                positionPickerView.selectRow(0, inComponent: 0, animated: false)
            }
        }
    }
    
    @IBAction func radMan(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        radWoman.isSelected = !sender.isSelected
        
        radMan.setImage(UIImage(named: sender.isSelected ? "rad_checked" : "rad"), for: .normal)
        radWoman.setImage(UIImage(named: !sender.isSelected ? "rad_checked" : "rad"), for: .normal)
    }
    
    @IBAction func radWoman(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        radMan.isSelected = !sender.isSelected
        
        radWoman.setImage(UIImage(named: sender.isSelected ? "rad_checked" : "rad"), for: .normal)
        radMan.setImage(UIImage(named: !sender.isSelected ? "rad_checked" : "rad"), for: .normal)
    }
    
    //them nhan vien moi vao db
    
    @IBAction func newMeal(_ sender: Any) {
        let employeeName = name.text ?? ""
        let employeePhone = phone.text!
        let employeeDOB = dob.text ?? ""
        let employeeAddress = address.text ?? ""
        var employeeGender = ""
        if(radMan.isSelected == true){
            employeeGender = "Nam"
        }
        else{
            employeeGender = "Nữ"
        }
        let employeePosition = selectedPosition ?? "Nhân viên"
        guard let image = employeeImage.image, let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let imageBase64 = imageData.base64EncodedString()
        var success = false
        
        //nếu employee tồn tại thì là update nhân viên
        if let employee = employee{
            success = dao.updateEmployee(employeeId: Int(employee.id)!, newName: employeeName, newImage: imageBase64, newGender: employeeGender, newPhone: employeePhone, newDOB: employeeDOB, newAddress: employeeAddress, newPosition: employeePosition, newPassword: employee.password)
        }
        else{
            //tạo nhân viên mới
            success =  dao.insertEmployee(name: employeeName, image: imageBase64, gender: employeeGender, phone: employeePhone, dob: employeeDOB, address: employeeAddress, position: employeePosition, password: "1")
        }
        if(success){
            if let listEmployee = storyboard?.instantiateViewController(withIdentifier: "EmployeeList") as? EmployeeListTableViewController {
                listEmployee.modalPresentationStyle = .fullScreen
                self.present(listEmployee, animated: true, completion: nil)
            }
        }
        else{
            UIAlertController(title: "", message: "Không thành công", preferredStyle: .alert)
        }
    }
    
    //MARK: ImagePickerController
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
        if let image = info[.originalImage]{
            employeeImage.image = image as? UIImage
        }
        //quay lai man hinh truoc
        dismiss(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return positons.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return positons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPosition = positons[row]
        print(selectedPosition)
    }
}
