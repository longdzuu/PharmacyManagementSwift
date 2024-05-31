//
//  BillListViewController.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 26/5/24.
//

import UIKit

class BillListViewController: UITableViewController {
    private let dao = Database()
    var bills = [Bill]()
    @IBOutlet weak var navigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //Them edit button cho navigation Bar
        let backButton = UIBarButtonItem(title: "Trở lại", style: .plain, target: self, action: #selector(backButtonTapped))
        //them nút back vào nav
        self.navigation.leftBarButtonItem = backButton
        
        bills = dao.getAllBill()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bills.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "BillListCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? BillListCell {
            // Lay du lieu tu datasource
            let bill = bills[indexPath.row]
            // Do du lieu tu employee vao cell
            cell.billID.text = "Mã HD: \(bill.id)"
            
            //lay ten nhan vien
            let employeeName = dao.getEmpoyeeById(employee_Id: "1")
            cell.billEmployeeName.text = employeeName
            cell.billDate.text = "\(bill.date)"
            
            return cell
        }
        // Khong tao duoc cell
        fatalError("Khong the tao cell")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dao.deleteBill(billId: bills[indexPath.row].id)
            bills.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func backButtonTapped() {
        if let homePage = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
            homePage.modalPresentationStyle = .fullScreen
            self.present(homePage, animated: true, completion: nil)
        }
    }
}
