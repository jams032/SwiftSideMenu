//
//  MenuModel.swift
//  SwiftSideMenu
//  Created by on 14/2/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import Foundation
import UIKit

class MenuModel: NSObject , NSCoding {
    
    // change the param according to your API structure when menu items comes from API
    @objc var Label: String!
    @objc var Url: String!
    @objc var Children = [MenuModel]()
    @objc var isSubMenu : NSNumber! // Local use only
    
    
    override init() {
        super.init()
    }
    
    //MARK: Initialization
    init(Label: String, Url: String, Rank : NSNumber ,Children: [MenuModel] ,isSubMenu: NSNumber) {
        
        //Initialize stored properties
        self.Label = Label
        self.Url = Url
        self.Children = Children
        self.isSubMenu = isSubMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let _ = aDecoder.decodeObject(forKey: "Label") as? String {
            self.Label = (aDecoder.decodeObject(forKey: "Label") as? String)!
        }
        if let _  = aDecoder.decodeObject(forKey: "Url") as? String {
            self.Url = (aDecoder.decodeObject(forKey: "Url") as? String)!
        }
        if let _ = aDecoder.decodeObject(forKey: "Children") as? [MenuModel] {
            self.Children = (aDecoder.decodeObject(forKey: "Children") as? [MenuModel])!
        }
        if let _ = aDecoder.decodeObject(forKey: "isSubMenu") as? NSNumber {
            self.isSubMenu = (aDecoder.decodeObject(forKey: "isSubMenu") as? NSNumber)!
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.Label, forKey: "Label")
        aCoder.encode(self.Url, forKey: "Url")
        aCoder.encode(self.Children, forKey: "Children")
        aCoder.encode(self.isSubMenu, forKey: "isSubMenu")
    }
    
}
