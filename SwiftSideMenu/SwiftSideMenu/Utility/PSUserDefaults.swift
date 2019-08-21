//
//  SwiftSideMenuUserDefaults.swift
//  WebViewPerformance
//
//  Created by  on 7/2/19.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class PSUserDefaults : NSObject {
    
    static let kAccessToken = "kAccessToken"
    static let kRefreshToken = "kRefreshToken"
    static let kAuthToken = "kAuthToken"

    static let kFCMToken = "kFCMToken"
    static let kDeviceId = "kDeviceId"
    static let kIsFCMTokenSentToServer = "kIsFCMTokenSentToServer"
    static let kMenuData = "kMenuData" // all menus data is saved with this key
    static let kApiWithHeader = "kApiWithHeader" //  detect server needs API call for menus.
    static let kNeedContentUpdate = "kNeedContentUpdate" //  detect App needs API call for menu changes
    static let kFirstLaunchStatus = "kFirstLaunchStatus" //  detect server needs API call first time , after login for menus data. works once in lifetime.
    static let kCookies = "kCookies"
    
    static let PSUserDefaults  =  UserDefaults.standard
    
    class func deviceId() -> NSString!
    {
        if let data = PSUserDefaults.string(forKey: kDeviceId)
        {
            return data as NSString
        }
        return ""
    }
    
    class func setDeviceId(tokenId : NSString)
    {
        PSUserDefaults.setValue(tokenId, forKey: kDeviceId)
        PSUserDefaults.synchronize()
    }
    
    class func getContentUpdateStatus() -> Bool{
        return PSUserDefaults.bool(forKey: kNeedContentUpdate)
    }
    
    class func setContentUpdateStatus(tokenId : Bool)
    {
        PSUserDefaults.set(tokenId, forKey: kNeedContentUpdate)
        PSUserDefaults.synchronize()
    }
    
    class func getFirstLaunchStatus() -> Bool{
        return PSUserDefaults.bool(forKey: kFirstLaunchStatus)
    }
    
    class func setFirstLaunchStatus(tokenId : Bool)
    {
        PSUserDefaults.set(tokenId, forKey: kFirstLaunchStatus)
        PSUserDefaults.synchronize()
    }
    
    class func getFCMToken() -> String{
        
        if let data = PSUserDefaults.string(forKey: kFCMToken) {
            return data
        }
        return ""
    }
    
    class func setFCMToken(tokenId : String)
    {
        PSUserDefaults.setValue(tokenId, forKey: kFCMToken)
        PSUserDefaults.synchronize()
    }
    
    class func getIsFCMTokenSentToServer() -> Bool{
        
        return PSUserDefaults.bool(forKey: kIsFCMTokenSentToServer)
        
    }
    
    class func setMenuData(tokenId : MenuListModel)
    {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: tokenId), forKey: kMenuData)
        UserDefaults.standard.synchronize()
    }
    
    class func getCookies() -> [HTTPCookie] {

        if PSUserDefaults.object(forKey: kCookies) == nil {
            return [HTTPCookie]()
        }
        return NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.object(forKey: kCookies) as! Data) as Data) as! [HTTPCookie]
    }
    
    class func setCookies(tokenId : [HTTPCookie])
    {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: tokenId), forKey: kCookies)
        UserDefaults.standard.synchronize()
    }
    
    class func getMenuData() -> MenuListModel {
        
        if PSUserDefaults.object(forKey: kMenuData) == nil {
            return MenuListModel()
        }
        return NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.object(forKey: kMenuData) as! Data) as Data) as! MenuListModel
    }
    
    class func setIsFCMTokenSentToServer(value : Bool) {
        PSUserDefaults.setValue(value, forKey: kIsFCMTokenSentToServer)
        PSUserDefaults.synchronize()
    }
    
    
    class func accessToken() -> String
    {
        if let data = PSUserDefaults.string(forKey: kAccessToken){
            let tempData = data.replacingOccurrences(of: "", with: "")
            return tempData
        }

        return ""
    }
    
    class func setAccessToken(tokenId : String)
    {
        PSUserDefaults.setValue(tokenId, forKey: kAccessToken)
        PSUserDefaults.synchronize()
    }
    
    //Token
    class func refreshToken() -> String
    {
        if let data = PSUserDefaults.string(forKey: kRefreshToken){
            return data
        }
        
        return ""
    }
    
    class func setRefreshToken(tokenId : String)
    {
        PSUserDefaults.setValue(tokenId, forKey: kRefreshToken)
        PSUserDefaults.synchronize()
    }
    
    //Auth Token
    class func authToken() -> String
    {
        if let data = PSUserDefaults.string(forKey: kAuthToken){
            return data
        }
        return ""
    }
    
    class func setAuthToken(tokenId : String)
    {
        PSUserDefaults.setValue(tokenId, forKey: kAuthToken)
        PSUserDefaults.synchronize()
    }
    
    class func isRequestAPIWithHeader() -> Bool
    {
       return PSUserDefaults.bool(forKey: kApiWithHeader)
    }
    
    class func setRequestAPIWithHeader(value : Bool)
    {
        PSUserDefaults.setValue(value, forKey: kApiWithHeader)
        PSUserDefaults.synchronize()
    }
    
    class func checkRestrictedWebsite (urlString : String) -> Bool {
        
        if urlString.contains("sharethis") || urlString.contains("doubleclick.net") || urlString.contains("driftt.com")  {
            return true
        }
       
        return false
    }
}
