//
//  class.swift
//  contacts
//
//  Created by Веригин С.И. on 27/05/2019.
//  Copyright © 2019 Веригин С.И. All rights reserved.
//
class ModelUsers  {
    var Surname: String?
    var Name: String?
    var patronymic: String?
    var tel: String?
    var position: String?
    var hb: String?
    var id: String?
    var mobtel: String?
    var HappybDay: String?
    var profileImageUrl: String?
    var isFriend: String?
    init (Surname: String?, id: String?, Name: String?, patronymic: String?, tel: String?, position: String?, hb: String?,profileImageUrl: String?, mobtel: String?, HappybDay: String?, isFriend: String?){
        self.Surname = Surname;
        self.id = id;
        self.Name = Name;
        self.patronymic = patronymic;
        self.tel = tel;
        self.position = position;
        self.hb = hb;
        self.profileImageUrl = profileImageUrl;
        self.HappybDay = HappybDay;
        self.mobtel = mobtel;
        self.isFriend = isFriend;
    }
}
