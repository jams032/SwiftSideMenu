//
//  MenuListModel.swift
//  SwiftSideMenu
//
//  Created by on 14/2/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import Foundation
import UIKit

class MenuListModel: NSObject , NSCoding {
    
    @objc  var Authenticated: NSNumber! = nil
    @objc var AuthData = AuthDataModel()
    @objc var Private = [MenuModel]()
    @objc  var Public = [MenuModel]()
    
    override init() {
        
        super.init()
    }
    
    //MARK: Initialization
    init(Authenticated: NSNumber, AuthData: AuthDataModel,Public: [MenuModel] ,Private: [MenuModel]) {
        
        //Initialize stored properties
        self.Authenticated = Authenticated
        self.AuthData = AuthData
        self.Private = Private
        self.Public = Public
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let _ = aDecoder.decodeObject(forKey: "Authenticated") as? NSNumber {
            self.Authenticated = (aDecoder.decodeObject(forKey: "Authenticated") as? NSNumber)!
        }
        if let _ = aDecoder.decodeObject(forKey: "AuthData") as? AuthDataModel {
            self.AuthData = (aDecoder.decodeObject(forKey: "AuthData") as? AuthDataModel)!
        }
        if let _ = aDecoder.decodeObject(forKey: "Private") as? [MenuModel] {
            self.Private = (aDecoder.decodeObject(forKey: "Private") as? [MenuModel])!
        }
        if let _ = aDecoder.decodeObject(forKey: "Public") as? [MenuModel] {
            self.Public = (aDecoder.decodeObject(forKey: "Public") as? [MenuModel])!
        }
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.Authenticated, forKey: "Authenticated")
        aCoder.encode(self.AuthData, forKey: "AuthData")
        aCoder.encode(self.Private, forKey: "Private")
        aCoder.encode(self.Public, forKey: "Public")
    }
    
}
