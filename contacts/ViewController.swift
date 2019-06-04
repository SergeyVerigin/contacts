//
//  ViewController.swift
//  contacts
//
//  Created by Веригин С.И. on 24/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase





class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [ModelUsers]()
    var db: DatabaseReference?
    

    var selectedSurname: String?
    var selectedName: String?
    var selectedPatronymic: String?
    var selectedPosition: String?
    var selectedPhone: String?
    var selectedImage: UIImage?
    var selectedUuid: String?
    var selectedMob: String?
    var selectedBDay: String?
    var selectedIsFriend: String?
    var PhotoUser: UIImage?
    var child: String?
    
    @IBAction func switchUser(sender: UISegmentedControl) {
        switch SegmentControl.selectedSegmentIndex {
        case 0:
            self.switchUser()
            break
        case 1:
            self.switchFriends()
            break
        default:
            break
        }
    }
    @IBOutlet weak var TableInfo: UITableView!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBAction func Add(_ sender: Any) {
    let vc = storyboard!.instantiateViewController(withIdentifier:
            "AddOrNot") as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: false)
    }
    @IBAction func ActionSegment(_ sender: Any) {
        TableInfo.reloadData()
    }
    func switchFriends() {
        db =  Database.database().reference().child("friends")
        db!.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0 {
                self.users.removeAll()
                for use in snapshot.children.allObjects as![DataSnapshot]{
                    let userObject = use.value as? [String: AnyObject]
                    let userSurname = userObject?["Surname"]
                    let userName = userObject?["Name"]
                    let userPatronymic = userObject?["patronymic"]
                    let userId = userObject?["id"]
                    let userTel = userObject?["tel"]
                    let userPosition = userObject?["position"]
                    let userHb = userObject?["hb"]
                    let userProfileImaurl = userObject?["profilePhoto"]
                    let userBDay = userObject?["HappybDay"]
                    let userMobTel = userObject?["MobTel"]
                    let userIsFriend = userObject? ["isFriend"]
                    let user = ModelUsers(Surname: userSurname as! String?, id: userId as! String?, Name: userName as! String?, patronymic: userPatronymic as! String?, tel: userTel as! String?, position: userPosition as! String?, hb: userHb as! String?, profileImageUrl: userProfileImaurl as! String?, mobtel: userMobTel as! String?, HappybDay: userBDay as! String?, isFriend: userIsFriend as! String?)
                    self.users.append(user)
                }
                self.TableInfo.reloadData()
            }
            else {
                self.users.removeAll()
                self.TableInfo.reloadData()
            }
        })
    }
    func switchUser() {
        db =  Database.database().reference().child("users");
        db!.observe(DataEventType.value, with: {(snapshot) in
            
            if snapshot.childrenCount>0 {
                self.users.removeAll()
                for use in snapshot.children.allObjects as![DataSnapshot]{
                    var userObject = use.value as? [String: AnyObject]
                    let userSurname = userObject?["Surname"]
                    let userName = userObject?["Name"]
                    let userPatronymic = userObject?["patronymic"]
                    let userId = userObject?["id"]
                    let userTel = userObject?["tel"]
                    let userPosition = userObject?["position"]
                    let userHb = userObject?["hb"]
                    let userProfileImaurl = userObject?["profilePhoto"]
                    let userBDay = userObject?["HappybDay"]
                    let userMobTel = userObject?["MobTel"]
                    let userIsFriend = userObject? ["isFriend"]
                    let user = ModelUsers(Surname: userSurname as! String?, id: userId as! String?, Name: userName as! String?, patronymic: userPatronymic as! String?, tel: userTel as! String?, position: userPosition as! String?, hb: userHb as! String?, profileImageUrl: userProfileImaurl as! String?, mobtel: userMobTel as! String?, HappybDay: userBDay as! String?, isFriend: userIsFriend as! String?)
                    self.users.append(user)
                }
              self.TableInfo.reloadData()
                
            }
            else {
                self.users.removeAll()
                self.TableInfo.reloadData()
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.switchUser()
        TableInfo.reloadData()
        }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue  = 0
        switch (SegmentControl.selectedSegmentIndex) {
        case 0:
            returnValue = users.count
            break
        case 1:
            returnValue = users.count
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactTableViewCell
        
        //Убираю выделение ячейки при тапе
         cell.selectionStyle = .none
       
        switch SegmentControl.selectedSegmentIndex {
        case 0:
            let contacts: ModelUsers
            contacts = users[indexPath.row]
            //Получение данных в ячейки
               DispatchQueue.main.async {
                cell.FIO.text = contacts.Surname! + " " + contacts.Name!
                cell.Phone.text = contacts.tel
                cell.Position.text = contacts.position
            }
            if let profileImageUrl = contacts.profileImageUrl {
                let url = URL(string: profileImageUrl)
                URLSession.shared.dataTask(with: url!, completionHandler:  {(data, response, error) in
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.PhotoProfile.image =  UIImage(data: data!)
                       self.PhotoUser = UIImage(data: data!)
                    }
                }).resume()
            }
            return cell
            break
        case 1:
            let contacts: ModelUsers
                contacts = self.users[indexPath.row]
                    cell.dobtel.isHidden = true
                    cell.FIO.text = contacts.Surname! + " " + contacts.Name!
                    cell.Phone.text = contacts.HappybDay
                    cell.Position.text = contacts.mobtel
            
            if let profileImageUrl = contacts.profileImageUrl {
                let url = URL(string: profileImageUrl)
                URLSession.shared.dataTask(with: url!, completionHandler:  {(data, response, error) in
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.PhotoProfile.image =  UIImage(data: data!)
                        self.PhotoUser = UIImage(data: data!)
                    }
                }).resume()
            }
            break
        default:
            break
        }
        return cell
    }
    //Удаление пользователя по свайпу из таблицы
    func DeleteContact (id: String) {
        db?.child(id).setValue(nil)
         TableInfo.reloadData()
    }
    //Обработки клика по нужной ячейке (передача большого кол-ва данных, можно упростить и передавать один  id  пользователя)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch (SegmentControl.selectedSegmentIndex) {
        case 0:
            let contacts: ModelUsers
            contacts = users[indexPath.row]
            selectedSurname = contacts.Surname
            selectedName = contacts.Name
            selectedPatronymic = contacts.patronymic
            selectedPosition = contacts.position
            selectedPhone = contacts.tel
            selectedUuid = contacts.id
            selectedImage = PhotoUser
            selectedMob = contacts.mobtel
            selectedBDay = contacts.HappybDay
            selectedIsFriend = contacts.isFriend
            performSegue(withIdentifier: "segue", sender: selectedSurname )
            break
        case 1:
            let contacts: ModelUsers
            contacts = users[indexPath.row]
            selectedSurname = contacts.Surname
            selectedName = contacts.Name
            selectedPatronymic = contacts.patronymic
            selectedPosition = contacts.position
            selectedPhone = contacts.tel
            selectedUuid = contacts.id
            selectedImage = PhotoUser
            selectedMob = contacts.mobtel
            selectedBDay = contacts.HappybDay
            selectedIsFriend = contacts.isFriend
            performSegue(withIdentifier: "segue", sender: selectedSurname )
            break
        default:
            break
        }
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        let contacts: ModelUsers
        contacts = users[indexPath.row]
        self.DeleteContact(id: contacts.id!)
        TableInfo.reloadData()
        }
    }
    //Если будет локальная БД, то передам один id
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "segue" {
            if let detail = segue.destination as? DetailViewController  {
            
                detail.loadViewIfNeeded()
                detail.sixText = selectedMob
                detail.sevenText = selectedBDay
                detail.thirdText = selectedPatronymic
                detail.secondText = selectedName
                detail.firstTex = selectedSurname
                detail.fourTex = selectedPosition
                detail.fiveText = selectedPhone
                detail.photoProfile = selectedImage
                detail.UUID = selectedUuid
                detail.isFriend = selectedIsFriend
             
            }
        }
    }
}

