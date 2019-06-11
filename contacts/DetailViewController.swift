//
//  DetailViewController.swift
//  contacts
//
//  Created by Веригин С.И. on 25/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage



class DetailViewController: UIViewController, UITextFieldDelegate {
   

   
    @IBOutlet weak var sevenTextField: UITextField!
    @IBOutlet weak var sixTextField: UITextField!
    @IBOutlet weak var five: UITextField!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var four: UITextField!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var uploadImage: UILabel!
    var photoProfileImage: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    var firstTex: String?
    var secondText: String?
    var thirdText: String?
    var fourTex: String?
    var fiveText: String?
    var id: String?
    var sixText: String?
    var sevenText: String?
    var UUID: String?
    var profilePhoto: String?
    var isFriend: String?
    var db: DatabaseReference?
    var child: String?
    @IBOutlet weak var editUser: UIButton!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var hbLabel: UILabel!
    @IBOutlet weak var dr: UILabel!
    @IBOutlet weak var mobtel: UILabel!
    @IBOutlet weak var switchUser: UISwitch!
    var uuid = NSUUID().uuidString
    @IBOutlet weak var save: UIButton!
    
    
    
    
    @IBAction func SWITCH(_ sender: Any) {
        if ((sender as AnyObject).isOn == false) {
          
            child = "users"
            dr.isHidden = true
            mobtel.isHidden = true
            sixTextField.isHidden = true
            sevenTextField.isHidden = true
            isFriend = "0"
        } else {
            child = "friends"
            sixTextField.isHidden = false
            sevenTextField.isHidden = false
            dr.isHidden = false
            mobtel.isHidden = false
            isFriend = "1"
        }
    }
    
  

    @IBAction func Edit(_ sender: Any) {
        
        firstTex = firstTextField.text
        secondText = secondTextField?.text
        thirdText = thirdTextField.text
        fourTex = four.text
        fiveText = five.text
        sixText = sixTextField.text
        sevenText = sevenTextField.text
        
       
        let storageDB = Storage.storage().reference().child("photo").child("\(uuid).png")
        if let uploadData = self.imageView.image!.pngData(){
            storageDB.putData(uploadData, metadata: nil, completion: { ( metadata, error) in
                if error == nil, metadata != nil {
                    let profilePhoto = storageDB.downloadURL { (url, error)
                        in
                        guard let downloadURL = url else {
                            return
                        }
                        self.profilePhoto = downloadURL.absoluteString
                        let values = ["Surname": self.firstTex, "Name": self.secondText, "patronymic": self.thirdText, "position": self.fourTex, "tel": self.fiveText, "hb": self.sixText, "id": self.UUID!, "profilePhoto": self.profilePhoto ,"HappybDay": self.sevenText , "MobTel": self.sixText, "isFriend": self.isFriend ] as [String : Any]
                        self.editUser(uuid: self.UUID!, values: values as [String : AnyObject])
                        }
                    }
                } )
            }
        }

   
    @IBAction func SavePeople(_ sender: Any) {
        firstTex = firstTextField.text
        secondText = secondTextField?.text
        thirdText = thirdTextField.text
        fourTex = four.text
        fiveText = five.text
        sixText = sixTextField.text
        sevenText = sevenTextField.text
        
        if firstTextField.text == "" || secondTextField?.text == "" {
            let alert = UIAlertController (title: "Заполните Фамилию и Имя", message: "", preferredStyle: .alert)
         
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
        
        let imageName = NSUUID().uuidString
        let storageDB = Storage.storage().reference().child("photo").child("\(imageName).png")
      
        if let uploadData = self.imageView.image!.pngData(){
           
            storageDB.putData(uploadData, metadata: nil, completion: { ( metadata, error) in
                if error == nil, metadata != nil {
                    
                    let profilePhoto = storageDB.downloadURL { (url, error)
                        in
                        guard let downloadURL = url else {
                            return
                        }
                        self.profilePhoto = downloadURL.absoluteString
                        
                        let values = ["Surname": self.firstTex, "Name": self.secondText, "patronymic": self.thirdText, "position": self.fourTex, "tel": self.fiveText, "hb": self.id, "id": self.uuid, "profilePhoto": self.profilePhoto, "HappybDay": self.sevenText , "MobTel": self.sixText, "isFriend": self.isFriend ] as [String : Any]
                        
                        self.addUser(uuid: self.uuid, values: values as! [String : AnyObject])
                        
                        }
                    }
                } )
            }
        }
       
    }

    @IBAction func Exit(_ sender: Any) {
        let vc = storyboard!.instantiateViewController(withIdentifier:
            "allInfo") as! ViewController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: false)
    }
    
  
    override func viewDidLoad() {
       
        super.viewDidLoad()
      
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectProfileImageview)))

        photoProfile.layer.borderWidth = 0.5
        photoProfile.layer.masksToBounds = false
        photoProfile.layer.borderColor = UIColor.white.cgColor
        photoProfile.layer.cornerRadius = photoProfile.frame.height/2
        photoProfile.clipsToBounds = true
        
        editUser.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        editUser.layer.cornerRadius = 25
        editUser.layer.borderWidth = 3
        editUser.layer.borderColor = UIColor(red: 1.0, green: 0.44, blue: 0.2, alpha: 1.0).cgColor
        save.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        save.layer.cornerRadius = 25
        save.layer.borderWidth = 3
        save.layer.borderColor = UIColor(red: 1.0, green: 0.44, blue: 0.2, alpha: 1.0).cgColor
        back.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        back.layer.cornerRadius = 20
        back.layer.borderWidth = 2
        back.layer.borderColor = UIColor(red: 0, green: 0, blue: 0.2, alpha: 0.7).cgColor
 
 
        DispatchQueue.main.async {
            self.firstTextField.text = self.firstTex
            self.secondTextField!.text = self.secondText
            self.thirdTextField.text = self.thirdText
            self.photoProfile.image = self.photoProfileImage
            self.four.text = self.fourTex
            self.five.text = self.fiveText
            self.sixTextField.text = self.sixText
            self.sevenTextField.text = self.sevenText
            
            if self.imageView.image == nil {
                self.uploadImage.isHidden = false
            } else {
                self.uploadImage.isHidden = true
            }
            if self.isFriend == "1" as? String {
                self.child = "friends"
                self.switchUser.isOn = true
                self.sixTextField.isHidden = false
                self.sevenTextField.isHidden = false
                self.dr.isHidden = false
                self.mobtel.isHidden = false
                self.save.isHidden = true
                self.back.isHidden = true
            } else {
                self.child = "users"
                self.isFriend = "0"
                self.switchUser.isOn = false
                self.save.isHidden =  true
                self.back.isHidden = true
            }
            if self.firstTex == nil  {
                self.child = "users"
                self.isFriend = "0"
                self.editUser.isHidden = true
                 self.save.isHidden = false
                self.back.isHidden = false
            } else {
             self.editUser.isHidden = false
                self.save.isHidden = true
            }
        }
        
    }
    
    }

