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
    var photoUser: UIImage?
    var child: String?
    @IBOutlet weak var tableInfo: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
   
    
    
    @IBAction func switchUser(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
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
    @IBAction func Add(_ sender: Any) {
    let vc = storyboard!.instantiateViewController(withIdentifier:
            "AddOrNot") as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: false)
    }
    @IBAction func actionSegment(_ sender: Any) {
        tableInfo.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.switchUser()
        tableInfo.reloadData()
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue  = 0
        switch (segmentControl.selectedSegmentIndex) {
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
       
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let contacts: ModelUsers
            contacts = users[indexPath.row]
            //Получение данных в ячейки
      
                cell.fio.text = contacts.Surname! + " " + contacts.Name!
                cell.phone.text = contacts.tel
                cell.position.text = contacts.position
            
                if let profileImageUrl = contacts.profileImageUrl {
                    let url = URL(string: profileImageUrl)
                    URLSession.shared.dataTask(with: url!, completionHandler:  {(data, response, error) in
                        if error != nil {
                            return
                        }
                        DispatchQueue.main.async {
                            cell.photoProfile.image =  UIImage(data: data!)
                            self.photoUser = UIImage(data: data!)
                        }
                    }).resume()
                }
            
          
            
            break
        case 1:
            let contacts: ModelUsers
                contacts = self.users[indexPath.row]
                    cell.dobtel.isHidden = true
                    cell.fio.text = contacts.Surname! + " " + contacts.Name!
                    cell.phone.text = contacts.HappybDay
                    cell.position.text = contacts.mobtel
            
            if let profileImageUrl = contacts.profileImageUrl {
                let url = URL(string: profileImageUrl)
                URLSession.shared.dataTask(with: url!, completionHandler:  {(data, response, error) in
                    if error != nil {
                        return
                    }
                    DispatchQueue.main.async {
                        cell.photoProfile.image =  UIImage(data: data!)
                        self.photoUser = UIImage(data: data!)
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
         tableInfo.reloadData()
    }
    //Обработки клика по нужной ячейке (передача большого кол-ва данных, можно упростить и передавать один  id  пользователя)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch (segmentControl.selectedSegmentIndex) {
        case 0:
            let contacts: ModelUsers
            contacts = users[indexPath.row]
            selectedSurname = contacts.Surname
            selectedName = contacts.Name
            selectedPatronymic = contacts.patronymic
            selectedPosition = contacts.position
            selectedPhone = contacts.tel
            selectedUuid = contacts.id
            selectedImage = photoUser
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
            selectedImage = photoUser
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
        tableInfo.reloadData()
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
                detail.photoProfileImage = selectedImage
                detail.UUID = selectedUuid
                detail.isFriend = selectedIsFriend
             
            }
        }
    }
}

