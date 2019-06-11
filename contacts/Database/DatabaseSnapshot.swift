//
//  DatabaseSnapshot.swift
//  contacts
//
//  Created by Веригин С.И. on 11/06/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//

import Foundation
import FirebaseDatabase
extension DetailViewController {

    func editUser(uuid: String, values: [String: AnyObject]) {
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

    func addUser(uuid: String, values: [String: AnyObject]) {
        
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
    
    
    
    
}

