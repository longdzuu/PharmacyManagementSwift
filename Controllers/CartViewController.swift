//
//  CartViewController.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 25/5/24.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var customerName: UILabel!
    static var customer = Customer(id: "", name: "", gender: "", phone: "", email: "", address: "")
    static var employee = Employee(id: "", name: "", gender: "", phone: "", dayOfBirth: "", address: "", position: "", password: "")
    
    var dao = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let backButton = UIBarButtonItem(title: "Trở lại", style: .plain, target: self, action: #selector(backButtonTapped))
        //let doneButton = UIBarButtonItem(title: "Cập nhập", style: .plain, target: self, action: #selector(bac())
        //them nút back vào nav
        self.navigation.leftBarButtonItem = backButton
        //self.navigation.rightBarButtonItem = doneButton
        
        //Đang ký BillCell vào tableView
        tableView.register(BillCell.self, forCellReuseIdentifier: "BillCell")
        
        //tên khách hàng
        customerName.text = "Khách hàng: \(CartViewController.customer.name) "
        
//        let drug = BillDetail(bill_id: 1, drugName: "Panadol", quantity: 2, price: 12000)
//        let drug1 = BillDetail(bill_id: 1, drugName: "Cồn 90 độ", quantity: 2, price: 20000)
//        LoginViewController.drugDetail.append(drug)
//        LoginViewController.drugDetail.append(drug1)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LoginViewController.drugDetail.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "BillCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? BillCell {
            //Kiểm tra nếu là dòng cuối thì tạo cell tổng cộng
            if(indexPath.row < LoginViewController.drugDetail.count){
                // Lay du lieu tu datasource
                let drug = LoginViewController.drugDetail[indexPath.row]
                // Do du lieu vao cell
                cell.drugName.text = drug.drugName
                cell.quantity.text = "\(drug.quantity)"
            }
            else{
                cell.drugName.text = "Tổng cộng: "
                cell.drugName.font = .boldSystemFont(ofSize: 18)
                cell.quantity.text = "\(BillDetail.totalPrice(billDetails: LoginViewController.drugDetail))"
            }
            
            return cell
        }
        // Khong tao duoc cell
        fatalError("Khong the tao cell")
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            //Cập nhập lại drugs
            Drug.updateQuantity(drugs: &SelectCustomerController.drugs, drugId: "\(LoginViewController.drugDetail[indexPath.row].drugId)", sellNumber: LoginViewController.drugDetail[indexPath.row].quantity * (-1))
            
            LoginViewController.drugDetail.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //load lại cart
            if let cart = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
                cart.modalPresentationStyle = .fullScreen
                self.present(cart, animated: true, completion: nil)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //su kien khi tap vao cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let custom = self.storyboard!.instantiateViewController(withIdentifier: "customDialog")
            as? CustomDialogController {
            //chuyển sang full màn hình
            custom.modalPresentationStyle = .fullScreen
            //Truyen khach hang sang AddEmployee
            
            
            //Chuyen man hinh
            self.present(custom, animated: true, completion: nil)
        }
    }
    
    //Su kien nut huy
    @IBAction func cancelCart(_ sender: Any) {
        //reset mang
        LoginViewController.drugDetail.removeAll()
        //Tao lai man hinh cart de cap nhap lai
        if let cart = self.storyboard!.instantiateViewController(withIdentifier: "CartViewController")
            as? CartViewController {
            //chuyển sang full màn hình
            cart.modalPresentationStyle = .fullScreen
            //Chuyen man hinh
            self.present(cart, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func newBill(_ sender: Any) {
        var success = dao.insertBill(customerID_bill: CartViewController.customer.id, employeeID_bill: "1")
        
        //lấy id hoá đơn mới tạo
        let newBillID = dao.getLatestBillID()
        
        //cap nhap lai billID cho chi tiet hoa don
        
        BillDetail.updateBillDetailBillID(billDetails: &LoginViewController.drugDetail, newBillID: newBillID!)
        
        for billDetail in LoginViewController.drugDetail{
            success = dao.insertBillDetail(billDetail: billDetail)
            //Giảm số lượng thuốc
            dao.updateDrugQuantity(drug_Id: billDetail.drugId, newQuantity: billDetail.quantity)
        }
        
        //Reset lại cart
        LoginViewController.drugDetail.removeAll()
        
        let alert = UIAlertController(title: "", message: "Thêm hoá đơn thành công", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
                                         
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}
