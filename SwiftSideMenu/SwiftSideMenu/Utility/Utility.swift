//
//  Utility.swift
//  SwiftSideMenu
//
//  Created by User Pc on 2/11/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import AVFoundation

class Utility {

    
    class func hexStringToUIColor (hex:String , alpha: Float) -> UIColor {
        
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class  func customFont(By size:(Float), style: Font_Style)-> UIFont {
        
        let fontFullName = fontByStyle(FontStyle: style)
        
        if fontFullName.count == 0 {
            return  UIFont(name: "Bold", size: CGFloat(size*SF))!
        }
        
        let font = UIFont(name: fontFullName, size: CGFloat(size*SF))!
        
        return  font
    }
    
    class func fontByStyle(FontStyle style:Font_Style)->String{
        var fontStyle = ""
        
        if style != .Regular {
            fontStyle = style.rawValue
            fontStyle = "-" + fontStyle
        }
        
        let fontFullName = Font_Family + fontStyle
        return fontFullName
        
    }
    
    class func deviceID() -> String{
        
        guard  let identifier = UIDevice.current.identifierForVendor else{
            return ""
        }
        return identifier.uuidString
    }
    
    class func openUrl(_ url: URL){
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        else if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        else if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func getVersionNumber () -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        return "Version - \(version)"
    }
    
    class func addLinearProgressBar (parentView : UIView , subView : LinearProgressBar ){

        subView.backgroundColor = Utility.hexStringToUIColor(hex: PROGRESS_MOVE_BG, alpha: 1)
        subView.progressBarColor = Utility.hexStringToUIColor(hex: PROGRESS_MOVE_COLOR, alpha: 1)
        subView.heightForLinearBar = 2.50
        parentView.addSubview(subView)
        
    }
    
}

extension UIImageView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    public func imageFromUrl(urlString: String) {

    let url = URL(string:
        urlString)
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async() {
            self.image = UIImage(data: data)
        }
    }
    task.resume()
    }
}


extension UIView {
    func addshadow(top: Bool,
                   left: Bool,
                   bottom: Bool,
                   right: Bool,
                   shadowRadius: CGFloat = 2.0) {
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        
        let path = UIBezierPath()
        var x: CGFloat = 0
        var y: CGFloat = 0
        var viewWidth = self.frame.width
        var viewHeight = self.frame.height
        
        // here x, y, viewWidth, and viewHeight can be changed in
        // order to play around with the shadow paths.
        if (!top) {
            y+=(shadowRadius+1)
        }
        if (!bottom) {
            viewHeight-=(shadowRadius+1)
        }
        if (!left) {
            x+=(shadowRadius+1)
        }
        if (!right) {
            viewWidth-=(shadowRadius+1)
        }
        // selecting top most point
        path.move(to: CGPoint(x: x, y: y))
        // Move to the Bottom Left Corner, this will cover left edges
        /*
         |☐
         */
        path.addLine(to: CGPoint(x: x, y: viewHeight))
        // Move to the Bottom Right Corner, this will cover bottom edge
        /*
         ☐
         -
         */
        path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
        // Move to the Top Right Corner, this will cover right edge
        /*
         ☐|
         */
        path.addLine(to: CGPoint(x: viewWidth, y: y))
        // Move back to the initial point, this will cover the top edge
        /*
         _
         ☐
         */
        path.close()
        self.layer.shadowPath = path.cgPath
}

}

extension String {
    func SizeOf() -> CGSize {
        
        
        let font = UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!
        //return self.SizeOfString(font: font!)
        print(self.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!]).width)
        return   self.size(withAttributes: [NSAttributedString.Key.font: font])

     //   return self.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: Page_Title_Font_SEMI_BOLD, size: Menu_SIZE)!])
    }
    
    func textWidth(text: String, font: UIFont?) -> CGSize {
        let attributes = font != nil ? [NSAttributedString.Key.font: font!] : [:]
        return text.size(withAttributes: attributes)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
 
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size
    }
    
    func textHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
}

extension UIButton {
    
public func imageFromUrl(urlString: String) {
    
    let url = URL(string:
        urlString)
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async() {
            self.setImage(UIImage(data: data), for: .normal)
        }
    }
    task.resume()
}
}
