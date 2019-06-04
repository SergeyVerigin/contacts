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


class DetailViewController: UIViewController {

   
    @IBOutlet weak var SevenTextField: UITextField!
    @IBOutlet weak var SixTextField: UITextField!
    @IBOutlet weak var Five: UITextField!
    @IBOutlet weak var PhotoProfile: UIImageView!
    @IBOutlet weak var FirstTextField: UITextField!
    @IBOutlet weak var ThirdTextField: UITextField!
    @IBOutlet weak var SecondTextField: UITextField!
    @IBOutlet weak var Four: UITextField!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var uploadImage: UILabel!
    var photoProfile: UIImage!
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
    @IBAction func SWITCH(_ sender: Any) {
        if ((sender as AnyObject).isOn == false) {
          
            child = "users"
            dr.isHidden = true
            mobtel.isHidden = true
            SixTextField.isHidden = true
            SevenTextField.isHidden = true
            isFriend = "0"
        } else {
            child = "friends"
            SixTextField.isHidden = false
            SevenTextField.isHidden = false
            dr.isHidden = false
            mobtel.isHidden = false
            isFriend = "1"
        }
    }
    
  
    @IBOutlet weak var Save: UIButton!
    @IBAction func Edit(_ sender: Any) {
        
        firstTex = FirstTextField.text
        secondText = SecondTextField.text
        thirdText = ThirdTextField.text
        fourTex = Four.text
        fiveText = Five.text
        sixText = SixTextField.text
        sevenText = SevenTextField.text
        
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
                        let values = ["Surname": self.firstTex, "Name": self.secondText, "patronymic": self.thirdText, "position": self.fourTex, "tel": self.fiveText, "hb": self.sixText, "id": self.UUID!, "profilePhoto": self.profilePhoto ,"HappybDay": self.sevenText , "MobTel": self.sixText, "isFriend": self.isFriend ] as [String : Any]
                        
                        self.editUser(uuid: self.UUID!, values: values as [String : AnyObject])
                        }
                }
                
            } )
          
            }
       
        
    }
    private func editUser(uuid: String, values: [String: AnyObject]) {
            db = Database.database().reference()
        if child == "users" as String? {

            db?.child("friends").child(UUID!).setValue(nil)
            
        } else {
            db?.child("users").child(UUID!).setValue(nil)
        }
        let usersReference = db?.child(child!).child(uuid)
        usersReference!.updateChildValues(values, withCompletionBlock: {
            (err, db) in
            if err != nil {
                print(err)
                return
            }
        })
        let delay = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier:
                "allInfo") as! ViewController
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: false)
        }

    }
   
    @IBAction func SavePeople(_ sender: Any) {
        firstTex = FirstTextField.text
        secondText = SecondTextField.text
        thirdText = ThirdTextField.text
        fourTex = Four.text
        fiveText = Five.text
        sixText = SixTextField.text
        sevenText = SevenTextField.text
        

      if FirstTextField.text == "" || SecondTextField.text == "" {
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
                        let uuid = NSUUID().uuidString
                        let values = ["Surname": self.firstTex, "Name": self.secondText, "patronymic": self.thirdText, "position": self.fourTex, "tel": self.fiveText, "hb": self.id, "id": uuid, "profilePhoto": self.profilePhoto, "HappybDay": self.sevenText , "MobTel": self.sixText, "isFriend": self.isFriend ] as [String : Any]
                        
                        self.addUser(uuid: uuid, values: values as! [String : AnyObject])
                        
                        }
                    }
                } )
        }
    }
       
}

    private func addUser(uuid: String, values: [String: AnyObject]) {
    
        db = Database.database().reference()
        let usersReference = db?.child(child!).child(uuid)
        usersReference!.updateChildValues(values, withCompletionBlock: {
            (err, db) in
            if err != nil {
                print(err)
                return
            }
        })
        let delay = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier:
                "allInfo") as! ViewController
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: false)
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

        PhotoProfile.layer.borderWidth = 0.5
        PhotoProfile.layer.masksToBounds = false
        PhotoProfile.layer.borderColor = UIColor.white.cgColor
        PhotoProfile.layer.cornerRadius = PhotoProfile.frame.height/2
        PhotoProfile.clipsToBounds = true
        
        editUser.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        editUser.layer.cornerRadius = 25
        editUser.layer.borderWidth = 3
        editUser.layer.borderColor = UIColor(red: 1.0, green: 0.44, blue: 0.2, alpha: 1.0).cgColor
        Save.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        Save.layer.cornerRadius = 25
        Save.layer.borderWidth = 3
        Save.layer.borderColor = UIColor(red: 1.0, green: 0.44, blue: 0.2, alpha: 1.0).cgColor
        back.backgroundColor = UIColor(red: 255, green: 248, blue: 244, alpha: 0.90)
        back.layer.cornerRadius = 20
        back.layer.borderWidth = 2
        back.layer.borderColor = UIColor(red: 0, green: 0, blue: 0.2, alpha: 0.7).cgColor
        //FirstTextField
      
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0.0, y: FirstTextField.frame.height - 1, width:
        FirstTextField.frame.width,height: 0.3)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        FirstTextField.borderStyle = UITextField.BorderStyle.none
        FirstTextField.layer.addSublayer(bottomLine)
        //SecondTextField
      
        let bottomLineSecond = CALayer()
        bottomLineSecond.frame = CGRect(x:0.0, y: SecondTextField.frame.height - 1, width:
        SecondTextField.frame.width,height: 0.3)
        bottomLineSecond.backgroundColor = UIColor.gray.cgColor
        SecondTextField.borderStyle = UITextField.BorderStyle.none
        SecondTextField.layer.addSublayer(bottomLineSecond)
        //ThirdTextField
        
        let bottomLineThird = CALayer()
        bottomLineThird.frame = CGRect(x:0.0, y: ThirdTextField.frame.height - 1, width:
        ThirdTextField.frame.width,height: 0.3)
        bottomLineThird.backgroundColor = UIColor.gray.cgColor
        ThirdTextField.borderStyle = UITextField.BorderStyle.none
        ThirdTextField.layer.addSublayer(bottomLineThird)
    
        //Four
    
        let bottomLineFour = CALayer()
        bottomLineFour.frame = CGRect(x:0.0, y: Four.frame.height - 1, width:
        Four.frame.width,height: 0.3)
        bottomLineFour.backgroundColor = UIColor.gray.cgColor
        Four.borderStyle = UITextField.BorderStyle.none
        Four.layer.addSublayer(bottomLineFour)
        //Five
       
        let bottomLineFive = CALayer()
        bottomLineFive.frame = CGRect(x:0.0, y: Five.frame.height - 1, width:
        Five.frame.width,height: 0.3)
        bottomLineFive.backgroundColor = UIColor.gray.cgColor
        Five.borderStyle = UITextField.BorderStyle.none
        Five.layer.addSublayer(bottomLineFive)
      
        //SixTextField
        let bottomLineSIx = CALayer()
        bottomLineSIx.frame = CGRect(x:0.0, y: SixTextField.frame.height - 1, width:
            SixTextField.frame.width,height: 0.3)
        bottomLineSIx.backgroundColor = UIColor.gray.cgColor
        SixTextField.borderStyle = UITextField.BorderStyle.none
        SixTextField.layer.addSublayer(bottomLineSIx)
        //SevenTextField
        let bottomLineSeven = CALayer()
        bottomLineSeven.frame = CGRect(x:0.0, y: SevenTextField.frame.height - 1, width:
            SevenTextField.frame.width,height: 0.3)
        bottomLineSeven.backgroundColor = UIColor.gray.cgColor
        SevenTextField.borderStyle = UITextField.BorderStyle.none
        SevenTextField.layer.addSublayer(bottomLineSeven)
    
        DispatchQueue.main.async {
            self.FirstTextField.text = self.firstTex
            self.SecondTextField.text = self.secondText
            self.ThirdTextField.text = self.thirdText
            self.PhotoProfile.image = self.photoProfile
            self.Four.text = self.fourTex
            self.Five.text = self.fiveText
            self.SixTextField.text = self.sixText
            self.SevenTextField.text = self.sevenText
            
            if self.imageView.image == nil {
                self.uploadImage.isHidden = false
            } else {
                self.uploadImage.isHidden = true
            }
            if self.isFriend == "1" as? String {
                self.child = "friends"
                self.switchUser.isOn = true
                self.SixTextField.isHidden = false
                self.SevenTextField.isHidden = false
                self.dr.isHidden = false
                self.mobtel.isHidden = false
                self.Save.isHidden = true
                self.back.isHidden = true
            } else {
                self.child = "users"
                self.isFriend = "0"
                self.switchUser.isOn = false
                self.Save.isHidden =  true
                self.back.isHidden = true
            }
            if self.firstTex == nil  {
                self.child = "users"
                self.isFriend = "0"
                self.editUser.isHidden = true
                 self.Save.isHidden = false
                self.back.isHidden = false
            } else {
             self.editUser.isHidden = false
                self.Save.isHidden = true
            }
        }
        
    }
    
    }

