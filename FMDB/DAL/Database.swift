//
//  Database.swift
//  PharmacyManagement
//
//  Created by VU HOANG DUY on 23/5/24.
//

import Foundation
import UIKit
import os.log

class Database {
    // MARK: Định nghĩa các thuộc tính chung của cơ sở dữ liệu
    private let DB_NAME = "pharmacy.sqlite"
    private let DB_PATH: String?
    private let database: FMDatabase?
    
    // MARK: Định nghĩa thuộc tính của bảng dữ liệu
    private let drugTableName = "drug"
    private let drugID = "_id"
    private let drugName = "ten"
    private let manu = "producer"
    private let drugHSD = "hsd"
    private let usage = "congDung"
    private let drugQuantily = "soLuong"
    private let drugUnit = "donViTinh"
    private let drugPrice = "gia"
    private let drugImage = "image"
    //MARK: Dinh nghia thuoc tinh cua bang du lieu customer
    private let customerTableName = "customer"
    private let customerID = "_id"
    private let customerGender = "gender"
    private let customerName = "name"
    private let customerAddress = "address"
    private let customerPhone = "phone"
    private let customerEmail = "email"
    //MARK: Dinh nghia thuoc tinh cua bang du lieu employee
    private let employeeTableName = "employee"
    private let employeeID = "_id"
    private let employeeName = "name"
    private let employeeImage = "image"
    private let employeeGender = "gender"
    private let employeePhone = "phone"
    private let employeeDOB = "dayOfBirth"
    private let employeeAddress = "address"
    private let employeePosition = "position"
    private let employeePassword = "password"
    //MARK: - Database Table Properties
    private let billTableName = "HoaDon"
    private let iD = "soHD"
    private let customerId = "maKH"
    private let employeeId = "maNV"
    private let billDate = "ngayLap"
    //MARK: Bill detail
    private let billDetailTableName = "Chitiethoadon"
    private let bill_id = "SoHD"
    private let drug_id = "Mathuoc"
    private let drug_name = "Tenthuoc"
    private let quantity = "Soluong"
    private let price = "Gia"
    
    // MARK: Constructors
    init() {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        DB_PATH = directories[0] + "/" + DB_NAME
        database = FMDatabase(path: DB_PATH)
        
        if database != nil {
            let drugTableCreationSQL = "CREATE TABLE IF NOT EXISTS \(drugTableName)("
            + "\(drugID) INTEGER PRIMARY KEY AUTOINCREMENT,"
            + "\(drugName) VARCHAR,"
            + "\(manu) VARCHAR,"
            + "\(drugImage) VARCHAR,"
            + "\(drugHSD) VARCHAR,"
            + "\(usage) VARCHAR,"
            + "\(drugQuantily) VARCHAR,"
            + "\(drugUnit) VARCHAR,"
            + "\(drugPrice) VARCHAR)"
            
            let customerTableCreationSQL = "CREATE TABLE IF NOT EXISTS \(customerTableName)("
            + "\(customerID) INTEGER PRIMARY KEY AUTOINCREMENT,"
            + "\(customerGender) TEXT,"
            + "\(customerName) TEXT,"
            + "\(customerAddress) TEXT,"
            + "\(customerPhone) TEXT,"
            + "\(customerEmail) TEXT)"
            
            let employeeTableCreationSQL = "CREATE TABLE IF NOT EXISTS \(employeeTableName)("
            + "\(employeeID) INTEGER PRIMARY KEY AUTOINCREMENT,"
            + "\(employeeName) TEXT,"
            + "\(employeeImage) TEXT,"
            + "\(employeeGender) TEXT,"
            + "\(employeePhone) TEXT,"
            + "\(employeeDOB) TEXT,"
            + "\(employeeAddress) TEXT,"
            + "\(employeePosition) TEXT,"
            + "\(employeePassword) TEXT)"
            
            let billTableCreationSQL = "CREATE TABLE IF NOT EXISTS \(billTableName)("
            + "\(iD) INTEGER PRIMARY KEY AUTOINCREMENT,"
            + "\(customerId) TEXT,"
            + "\(employeeID) TEXT,"
            + "\(billDate) TEXT DEFAULT (date('now')))"
            
            let billDetailTableCreationSQL = "CREATE TABLE IF NOT EXISTS \(billDetailTableName)("
            + "\(bill_id) INTEGER,"
            + "\(drug_id) INTEGER,"
            + "\(drug_name) TEXT,"
            + "\(quantity) INTEGER,"
            + "\(price) FLOAT)"
            
            if tableCreate(sql: drugTableCreationSQL, tableName: drugTableName) &&
                tableCreate(sql: customerTableCreationSQL, tableName: customerTableName) &&
                tableCreate(sql: employeeTableCreationSQL, tableName: employeeTableName) &&
                tableCreate(sql: billTableCreationSQL, tableName: billTableName) &&
                tableCreate(sql: billDetailTableCreationSQL, tableName: billDetailTableName){
            }
            os_log("Khởi tạo CSDL thành công")
        }
        else {
            os_log("Khởi tạo CSDL thất bại")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Định nghĩa các hàm primitives của CSDL
    ////////////////////////////////////////////////////////////////////////////////////////////
    private func open() -> Bool {
        var OK = false
        if database != nil {
            if database!.open() {
                os_log("Mở CSDL thành công")
                OK = true
            } else {
                os_log("Mở CSDL thất bại")
            }
        }
        return OK
    }
    
    private func close() {
        if database != nil {
            database!.close()
        }
    }
    
    private func tableCreate(sql: String, tableName: String) -> Bool {
        var OK = false
        if open() {
            if !database!.tableExists(tableName) {
                if database!.executeStatements(sql) {
                    os_log("Tạo bảng \(tableName) thành công")
                    OK = true
                } else {
                    os_log("Tạo bảng \(tableName) thất bại")
                }
            }
        }
        close()
        return OK
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Định nghĩa các hàm APIs của CSDL
    ////////////////////////////////////////////////////////////////////////////////////////////
    //MARK: - Drug Method
    func getAllDrugs() -> [Drug] {
        var drugs = [Drug]()
        if open() {
            let sql = "SELECT * FROM \(drugTableName)"
            if let results = database!.executeQuery(sql, withArgumentsIn: []) {
                while results.next() {
                    let id = results.string(forColumn: drugID) ?? ""
                    let ten = results.string(forColumn: drugName) ?? ""
                    let nhaSX = results.string(forColumn: manu) ?? ""
                    let hanSD = results.string(forColumn: drugHSD) ?? ""
                    let congDung = results.string(forColumn: usage) ?? ""
                    let soLuong = results.string(forColumn: drugQuantily) ?? ""
                    let donViTinh = results.string(forColumn: drugUnit) ?? ""
                    let gia = results.string(forColumn: drugPrice) ?? ""
                    
                    var image: UIImage? = nil
                    if let imageStr = results.string(forColumn: drugImage) {
                        if !imageStr.isEmpty {
                            // Chuyển chuỗi thành ảnh
                            if let dataImage = Data(base64Encoded: imageStr, options: .ignoreUnknownCharacters) {
                                image = UIImage(data: dataImage)
                            }
                        }
                    }
                    
                    let drug = Drug(id: id, name: ten, manufacturer: nhaSX, image: image, expirationDate: hanSD, usage: congDung, quantity: soLuong, unit: donViTinh, price: gia)
                    drugs.append(drug)
                }
            }
            close()
        }
        return drugs
    }

    
        func insertDrug(name: String, producer: String, image: String, hsd: String, uses: String, quantity: String, unit: String, price: String) -> Bool {
            var OK = false
            if open() {
                let sql = "INSERT INTO \(drugTableName) (\(drugName), \(manu), \(drugImage), \(drugHSD), \(usage), \(drugQuantily), \(drugUnit), \(drugPrice)) VALUES (?,?,?,?,?,?,?,?)"
                if database!.executeUpdate(sql, withArgumentsIn: [name, producer, image, hsd, uses, quantity, unit, price]) {
                    os_log("Thêm thuốc thành công")
                    OK = true
                } else {
                    os_log("Thêm thuốc thất bại")
                }
                close()
            }
            return OK
        }
        func deleteDrug(drugId: String) -> Bool {
            var OK = false
            if open() {
                let sql = "DELETE FROM \(drugTableName) WHERE \(drugID) = ?"
                if database!.executeUpdate(sql, withArgumentsIn: [drugId]) {
                    os_log("Xóa thuốc thành công")
                    OK = true
                } else {
                    os_log("Xóa thuốc thất bại")
                }
                close()
            }
            return OK
        }
    
        func updateDrug(drugId: String, newName: String, newProducer: String, newImage: String, newHSD: String, newUses: String, newQuantity:  String, newUnit: String, newPrice: String) -> Bool {
            var OK = false
            if open() {
                let sql = """
                UPDATE \(drugTableName) SET
                                        \(drugName) = ?,
                                        \(manu) = ?,
                                        \(drugImage) = ?,
                                        \(drugHSD) = ?,
                                        \(usage) = ?,
                                        \(drugQuantily) = ?,
                                        \(drugUnit) = ?,
                                    \(drugPrice) = ?
                WHERE \(drugID) = ?
                """
                if database!.executeUpdate(sql, withArgumentsIn: [newName, newProducer, newImage, newHSD, newUses, newQuantity, newUnit, newPrice, drugId]) {
                    os_log("Cập nhật thuốc thành công")
                    OK = true
                } else {
                    os_log("Cập nhật thuốc thất bại")
                }
                close()
            }
            return OK
        }
    
    func updateDrugQuantity(drug_Id: Int, newQuantity: Int) -> Bool {
        var OK = false
        if open() {
            let sql = "UPDATE \(drugTableName) SET \(drugQuantily) = \(drugQuantily) - ? WHERE \(drugID) = ?"
            if database!.executeUpdate(sql, withArgumentsIn: [newQuantity, drug_Id]) {
                os_log("Cập nhật thuốc thành công")
                OK = true
            } else {
                os_log("Cập nhật thuốc thất bại")
            }
            close()
        }
        return OK
    }
    
    // MARK: - Customer Methods
    func getAllCustomers() -> [Customer] {
        var customers = [Customer]()
        if open() {
            let sql = "SELECT * FROM \(customerTableName)"
            if let results = database!.executeQuery(sql, withArgumentsIn: []) {
                while results.next() {
                    let id = results.string(forColumn: customerID) ?? ""
                    let gender = results.string(forColumn: customerGender) ?? ""
                    let name = results.string(forColumn: customerName) ?? ""
                    let address = results.string(forColumn: customerAddress) ?? ""
                    let phone = results.string(forColumn: customerPhone) ?? ""
                    let email = results.string(forColumn: customerEmail) ?? ""
                    
                    // Tạo một đối tượng Customer và thêm vào mảng customers
                    let customer = Customer(id:id, name: name, gender: gender, phone: phone, email: email, address: address)
                    customers.append(customer)
                    
                    
                }
            }
            close()
        }
        return customers
    }
    
    func insertCustomer(name: String, gender:String, address: String, phone: String, email: String) -> Bool {
        var success = false
        if open() {
            let sql = "INSERT INTO \(customerTableName) (\(customerName), \(customerGender), \(customerAddress), \(customerPhone), \(customerEmail)) VALUES (?,?,?,?,?)"
            if database!.executeUpdate(sql, withArgumentsIn: [ name, gender, address, phone, email]) {
                os_log("Thêm khách hàng thành công")
                success = true
            } else {
                os_log("Thêm khách hàng thất bại")
            }
            close()
        }
        return success
    }
    func deleteCustomer(customerId: Int) -> Bool {
        var success = false
        if open() {
            let sql = "DELETE FROM \(customerTableName) WHERE \(customerID) = ?"
            if database!.executeUpdate(sql, withArgumentsIn: [customerId]) {
                os_log("Xóa khách hàng thành công")
                success = true
            } else {
                os_log("Xóa khách hàng thất bại")
            }
            close()
        }
        return success
    }
    func updateCustomer(customerId: Int, newName: String,  newGender:String,newAddress: String, newPhone: String, newEmail: String) -> Bool {
        var success = false
        if open() {
            let sql = """
                UPDATE \(customerTableName) SET
                                \(customerName) = ?,
                    \(customerGender) = ?,
                    \(customerAddress) = ?,
                    \(customerPhone) = ?,
                    \(customerEmail) = ?
                WHERE \(customerID) = ?
                """
            if database!.executeUpdate(sql, withArgumentsIn: [newName, newGender, newAddress, newPhone, newEmail, customerId]) {
                os_log("Cập nhật khách hàng thành công")
                success = true
            } else {
                os_log("Cập nhật khách hàng thất bại")
            }
            close()
        }
        return success
    }
    
    //MARK: Employee methods
    func getAllEmployees(employees: inout[Employee]){
        if open(){
            if database!.tableExists(employeeTableName){
                // Cau lenh sql
                let sql = "SELECT * FROM \(employeeTableName)"
                // Khai bao bien chua du lieu doc ve tu CSDL
                var result:FMResultSet?
                do{
                    result = try database!.executeQuery(sql, values: nil)
                }
                catch{
                    os_log("Khong the truy van csdl")
                }
                
                // Doc du lieu tu bien result
                if let result = result{
                    while result.next() {
                        let id = result.string(forColumn: employeeID) ?? ""
                        let name = result.string(forColumn: employeeName) ?? ""
                        let gender = result.string(forColumn: employeeGender) ?? ""
                        let phone = result.string(forColumn: employeePhone) ?? ""
                        let dob = result.string(forColumn: employeeDOB) ?? ""
                        let address = result.string(forColumn: employeeAddress) ?? ""
                        let position = result.string(forColumn: employeePosition) ?? ""
                        let password = result.string(forColumn: employeePassword) ?? ""
                        
                        var image:UIImage? = nil
                        if let strImage = result.string(forColumn: employeeImage){
                            if !strImage.isEmpty{
                                // chuyen chuoi thanh anh
                                // B1. Chuyen chuoi sang nsdata
                                let dataImage = Data(base64Encoded: strImage,options: .ignoreUnknownCharacters)
                                // B2. chuyen anh thanh UIImage
                                image = UIImage(data: dataImage!)
                            }
                        }
                        //Tao doi tuong meal tu CSDL
                        let employee = Employee(id: id, name: name,image: image, gender: gender, phone: phone, dayOfBirth: dob, address: address, position: position, password: password)
                        // Dua vao datasource cua tableview
                        employees.append(employee)
                    }
                }
            }
        }
    }
    
    func getEmpoyeeById(employee_Id:String)->String{
        var name:String = ""
        if open() {
            let sql = "SELECT \(employeeName) from \(employeeTableName)"
                       + " WHERE employeeID = ?"
            if let results = database!.executeQuery(sql, withArgumentsIn: [1]) {
                if results.next() {
                    name = results.string(forColumnIndex: 0)!
                }
                results.close()
            }
            close()
        }
        return name
    }
    
    func insertEmployee(name: String, image: String, gender: String, phone: String, dob: String, address: String, position: String, password: String) -> Bool {
        var success = false
        if open() {
            let sql = "INSERT INTO \(employeeTableName) (\(employeeName), \(employeeImage), \(employeeGender), \(employeePhone), \(employeeDOB), \(employeeAddress), \(employeePosition), \(employeePassword)) VALUES (?,?,?,?,?,?,?,?)"
            if database!.executeUpdate(sql, withArgumentsIn: [name, image, gender, phone, dob, address, position, password]) {
                os_log("Thêm nhân viên thành công")
                success = true
            } else {
                os_log("Thêm nhân viên thất bại")
            }
            close()
        }
        return success
    }
    
    func deleteEmployee(employeeId: Int) -> Bool {
        var success = false
        if open() {
            let sql = "DELETE FROM \(employeeTableName) WHERE \(employeeID) = ?"
            if database!.executeUpdate(sql, withArgumentsIn: [employeeId]) {
                os_log("Xóa nhân viên thành công")
                success = true
            } else {
                os_log("Xóa nhân viên thất bại")
            }
            close()
        }
        return success
    }
    
    func updateEmployee(employeeId: Int, newName: String, newImage: String, newGender: String, newPhone: String, newDOB: String, newAddress: String, newPosition: String, newPassword: String) -> Bool {
        var success = false
        if open() {
            let sql = """
                UPDATE \(employeeTableName) SET
                    \(employeeName) = ?,
                    \(employeeImage) = ?,
                    \(employeeGender) = ?,
                    \(employeePhone) = ?,
                    \(employeeDOB) = ?,
                    \(employeeAddress) = ?,
                    \(employeePosition) = ?,
                    \(employeePassword) = ?
                WHERE \(employeeID) = ?
                """
            if database!.executeUpdate(sql, withArgumentsIn: [newName, newImage, newGender, newPhone, newDOB, newAddress, newPosition, newPassword, employeeId]) {
                os_log("Cập nhật nhân viên thành công")
                success = true
            } else {
                os_log("Cập nhật nhân viên thất bại")
            }
            close()
        }
        return success
    }
    
    // MARK: - Bill Methods
    func getAllBill() -> [Bill] {
        var bills = [Bill]()
        if open() {
            let sql = "SELECT * FROM \(billTableName)"
            if let results = database!.executeQuery(sql, withArgumentsIn: []) {
                while results.next() {
                    let soHD = results.int(forColumn: iD)
                    let maKH = results.string(forColumn: customerId) ?? ""
                    let maNV = results.string(forColumn: employeeID) ?? ""
                    let ngayLap = results.string(forColumn: billDate) ?? ""
                    
                    let bill = Bill(id: Int(soHD), customer_id: maKH, employee_id: maNV, date: ngayLap)
                    bills.append(bill)
                }
            }
            close()
        }
        return bills
    }
    
    func getLatestBillID() -> Int? {
        var bill_id: Int?
        if open() {
            let sql = "SELECT last_insert_rowid()"
            if let results = database!.executeQuery(sql, withArgumentsIn: []) {
                if results.next() {
                    bill_id = Int(results.int(forColumnIndex: 0))
                }
                results.close()
            }
            close()
        }
        return bill_id
    }

    
    func insertBill(customerID_bill:String, employeeID_bill:String) -> Bool {
        var success = false
        if open() {
            let sql = "INSERT INTO \(billTableName) (\(customerId), \(employeeID)) VALUES (?,?)"
            if database!.executeUpdate(sql, withArgumentsIn: [customerID_bill, employeeID_bill]) {
                os_log("Thêm hoá đơn thành công")
                success = true
            }
            else
            {
                os_log("Thêm hoá đơn thất bại")
            }
            close()
        }
        return success
    }
    
    func deleteBill(billId: Int) -> Bool {
        var success = false
        if open() {
            let sql = "DELETE FROM \(billTableName) WHERE \(bill_id) = ?"
            if database!.executeUpdate(sql, withArgumentsIn: [billId]) {
                os_log("Xóa hoá đơn thành công")
                success = true
            } else {
                os_log("Xóa hoá đơn thất bại")
            }
            close()
        }
        return success
    }
    
    //MARK: - Bill Detail
    
    func getAllBillDetail() -> [BillDetail] {
        var billDetails = [BillDetail]()
        if open() {
            let sql = "SELECT * FROM \(billDetailTableName)"
            if let results = database!.executeQuery(sql, withArgumentsIn: []) {
                while results.next() {
                    let id = results.int(forColumn: bill_id)
                    let drugId = results.int(forColumn: drug_id)
                    let drugName = results.string(forColumn: drug_name) ?? ""
                    let quantity = results.int(forColumn: quantity)
                    let price = results.double(forColumn: price)
                    
                    let billDetail = BillDetail(bill_id: Int(id), drugId: Int(drugId), drugName: drugName, quantity: Int(quantity), price: Float(price))
                    billDetails.append(billDetail)
                }
            }
            close()
        }
        return billDetails
    }
    
    func insertBillDetail(billDetail:BillDetail) -> Bool {
        var success = false
        if open() {
            let sql = "INSERT INTO \(billDetailTableName) (\(bill_id),\(drug_id), \(drug_name), \(quantity), \(price)) VALUES (?,?,?,?,?)"
            if database!.executeUpdate(sql, withArgumentsIn: [ billDetail.bill_id, billDetail.drugId, billDetail.drugName, billDetail.quantity, billDetail.price]) {
                os_log("Thêm chi tiết hoá đơn thành công")
                success = true
            } else {
                os_log("Thêm chi tiết hoá đơn thất bại")
            }
            close()
        }
        return success
    }
    
    func deleteBillDetail(billId: Int) -> Bool {
        var success = false
        if open() {
            let sql = "DELETE FROM \(billDetailTableName) WHERE \(bill_id) = ?"
            if database!.executeUpdate(sql, withArgumentsIn: [billId]) {
                os_log("Xóa chi tiết hoá đơn thành công")
                success = true
            } else {
                os_log("Xóa chi tiết hoá đơn thất bại")
            }
            close()
        }
        return success
    }
}


