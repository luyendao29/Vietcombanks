//
//  SideViewController.swift
//  Vietcombanks
//
//  Created by Boss on 7/9/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit

class SideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var mytableView: UITableView!
    @IBOutlet weak var photos: DesignableImageView!
    var imagePicker = UIImagePickerController()
    var imagee: Data?
    var side: [Side] = [
        Side(image: UIImage(named: "account")!, name: "Tài khoản/Thẻ"),
        Side(image: UIImage(named: "money")!, name: "Chuyển tiền"),
        Side(image: UIImage(named: "sqrpay")!, name: "QR PAY"),
        Side(image: UIImage(named: "sphone")!, name: "Nạp tiền điện thoại"),
        Side(image: UIImage(named: "sbill")!, name: "Thanh toán hoá đơn"),
        Side(image: UIImage(named: "scheap")!, name: "Tiết kiệm trực tuyến"),
        Side(image: UIImage(named: "scredis")!, name: "Thanh toán thẻ tín dụng"),
        Side(image: UIImage(named: "snegotiate")!, name: "Báo cáo giao dịch"),
        Side(image: UIImage(named: "atm")!, name: "ATM/ Chi nhánh"),
        Side(image: UIImage(named: "laisuat")!, name: "Lãi suất"),
        Side(image: UIImage(named: "tygia")!, name: "Tỷ giá"),
        Side(image: UIImage(named: "atm")!, name: "Thông tin Vietcombank"),
        Side(image: UIImage(named: "icons8-airport")!, name: "Đặt vé máy bay"),
        Side(image: UIImage(named: "smanagement")!, name: "Quản lí đầu tư"),
        Side(image: UIImage(named: "schangepass")!, name: "Đổi mật khẩu"),
        Side(image: UIImage(named: "sFingerprint installation")!, name: "Cài đặt vân tay"),
        Side(image: UIImage(named: "scontact")!, name: "Danh bạ thụ hưởng"),
        Side(image: UIImage(named: "sUser manual")!, name: "Hướng dẫn sử dụng")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.dataSource = self
        mytableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return side.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SideTableViewCell
        cell!.images.image = side[indexPath.row].image
        cell!.labelname.text = side[indexPath.row].name
        return cell!
    }
}
extension SideViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func BtnChonAnh(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Thông Báo", message: "Chọn Ảnh", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "📗 Chọn Ảnh", style: .default, handler: {(action: UIAlertAction) in self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Thoát", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("asdasdas")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagee = tempImage.pngData()
            photos.image = tempImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
