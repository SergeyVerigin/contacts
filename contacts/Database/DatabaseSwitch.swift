//
//  DatabaseSwitch.swift
//  contacts
//
//  Created by Веригин С.И. on 11/06/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import Foundation
import FirebaseDatabase


extension ViewController {
  
// MARK: - Getting a database snapshot with friends
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
            self.tableInfo?.reloadData()
        }
        else {
            self.users.removeAll()
            self.tableInfo?.reloadData()
        }
    })
}

// MARK: - Getting a database snapshot with colleagues
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
            self.tableInfo.reloadData()
            
        }
        else {
            self.users.removeAll()
            self.tableInfo.reloadData()
            
            }
        })
    }
}
