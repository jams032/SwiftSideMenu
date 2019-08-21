import Foundation
import UIKit

class AuthDataModel: NSObject , NSCoding {
    
    @objc var Messages: NSNumber!
    @objc var Notifications: NSNumber!
    @objc var ProfilePhoto: String!
    @objc var UserID: NSNumber!
    

    
    //MARK: Initialization
    override init() {
        super.init()
    }
    init(Messages: NSNumber, Notifications: NSNumber, ProfilePhoto : String , UserID : NSNumber ) {
        self.Messages = Messages
        self.Notifications = Notifications
        self.ProfilePhoto = ProfilePhoto
        self.UserID = UserID
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let _ = aDecoder.decodeObject(forKey: "Messages") as? NSNumber {
            self.Messages = (aDecoder.decodeObject(forKey: "Messages") as? NSNumber)!
        }
        if let _  = aDecoder.decodeObject(forKey: "Notifications") as? NSNumber {
            self.Notifications = (aDecoder.decodeObject(forKey: "Notifications") as? NSNumber)!
        }
        if let _ = aDecoder.decodeObject(forKey: "ProfilePhoto") as? String {
            self.ProfilePhoto = (aDecoder.decodeObject(forKey: "ProfilePhoto") as? String)!
        }
        if let _ = aDecoder.decodeObject(forKey: "UserID") as? NSNumber {
            self.UserID = (aDecoder.decodeObject(forKey: "UserID") as? NSNumber)!
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.Messages, forKey: "Messages")
        aCoder.encode(self.Notifications, forKey: "Notifications")
        aCoder.encode(self.ProfilePhoto, forKey: "ProfilePhoto")
        aCoder.encode(self.UserID, forKey: "UserID")
    }
    
}
