

import UIKit


 class Mapper: NSObject {
    
  @objc  class  func objectOfDictionary(dictionary : [String:AnyObject]!, cClass:NSObject.Type, object : NSObject){
    
        var count:UInt32 = 0
        guard let properties = class_copyPropertyList(cClass, &count) else { return }
        
        
        for i in 0...count-1 {
            let property = properties[Int(i)]
            let propertyNameC = property_getName(property)
            let propertyName =  String(cString: propertyNameC)
            
            if let dic = dictionary {
                
                let value = dic[propertyName]
                
                if value != nil && !((value?.isEqual(NSNull()))!) {
                    object.setValue(value, forKey: propertyName)
                }
                else {
                    continue
                }
            }
            else {
                continue
            }
        }
        
        free(properties)
    }

    
    class func getMenuList(From dic:[String:AnyObject]!)-> MenuListModel{
        
        let apiData = MenuListModel()
        
        
        print(apiData.description)
        return apiData
    }

    
    class func getPublicPrivateData(From dic:[AnyObject]!)->[MenuModel]{

        var allMenus = [MenuModel]()
        
        return allMenus
    }
    
    class func getEachSubMenuItem(From dic:[AnyObject]!)->[MenuModel]{

        var mMenuItems = [MenuModel]()
        for item in dic{
            let tempdic = item as! [String:AnyObject]
            let mMenuItem = MenuModel()
            objectOfDictionary(dictionary: tempdic, cClass: MenuModel.self, object: mMenuItem)
            print(mMenuItem.Label)
            mMenuItems.append(mMenuItem)
        }
        return mMenuItems
    }

    class func getAuthdata(From dic:AnyObject)->AuthDataModel{
        
        let tempdic = dic as! [String:AnyObject]
        let mMenuItem = AuthDataModel()
        objectOfDictionary(dictionary: tempdic, cClass: AuthDataModel.self, object: mMenuItem)
        return mMenuItem
    }
    
    
   class func json(From data:AnyObject)->Data!{
    
    do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            print("Json ; \(jsonData)")
            return jsonData
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

