//
//  PSConstants.swift
//  SwiftSideMenu
//
//  Created by  on 10/2/19.
//  Copyright © 2019 Jamshed Alam. All rights reserved.
//

import Foundation
import UIKit


// // Live
let DOMAIN_URL = "https://www.SwiftSideMenu.com.au"
let DEV_URL = "https://103.217.110.147:18080"
let DOMAIN_ROOT = "SwiftSideMenu.com.au"
let LOGOUT_URL = "https://www.SwiftSideMenu.com.au/Account/Logout"
let LOGIN_WITH_REFRESH_TOKEN = "https://www.SwiftSideMenu.com.au/login/refresh?token="
let LOGIN_SUCCEEDED = "SwiftSideMenu.com.au/Account?login=true"
let PHOTO_CHANGE_URL = "https://www.SwiftSideMenu.com.au/Account/Photo"
let LOGIN_URL = "https://www.SwiftSideMenu.com.au/Login"

//// // Dev
//let DOMAIN_URL = "http://dev.SwiftSideMenu.com.au"
//let DEV_URL = "http://103.217.110.147:18080"
//let DOMAIN_ROOT = "SwiftSideMenu.com.au"
//let LOGOUT_URL = "http://dev.SwiftSideMenu.com.au/Account/Logout"
//let LOGIN_WITH_REFRESH_TOKEN = "http://dev.SwiftSideMenu.com.au/login/refresh?token="
//let LOGIN_SUCCEEDED = "SwiftSideMenu.com.au/Account?login=true"
//let PHOTO_CHANGE_URL = "http://dev.SwiftSideMenu.com.au/Account/Photo"
//let LOGIN_URL = "http://dev.SwiftSideMenu.com.au/Login"

//// Local
//let DOMAIN_URL = "http://103.217.110.147:18080"
//let DEV_URL = "http://103.217.110.147:18080"
//let DOMAIN_ROOT = "http://103.217.110.147"
//let LOGOUT_URL = "http://103.217.110.147:18080/Account/Logout"
//let LOGIN_WITH_REFRESH_TOKEN = "http://103.217.110.147:18080/login/refresh?token="
//let LOGIN_SUCCEEDED = "http://103.217.110.147:18080/Account?login=true"
//let PHOTO_CHANGE_URL = "http://103.217.110.147:18080/Account/Photo"
//let LOGIN_URL = "http://103.217.110.147:18080/Login"

let FINDSTAFF_URL = "/staff/search"
let JOBS_URL = "/Job"
let MESSAGES_URL = "/Messages/Index"
let Profile_URL = "/Account/Profile"
let FB_AUTH_URL1 = "facebook.com"
let FB_AUTH_URL2 = "dialog/oauth"
let FB_AUTH_URL3 = "facebook.com/login.php"
let FB_AUTH_URL4 = "facebook.com/plugins/share_button"
let FB_SHARER_PART1 = "https://www.facebook.com/sharer/sharer.php?kid_directed_site=0&sdk=joey&u="
let FB_SHARER_PART2 = "&display=popup&ref=plugin&src=share_button"
let FB_HOME_URL = "facebook.com/home.php"
let APP_IDENTITY = "iosapp"
let MENU_LIST = "/api/info/basic"
let AUTH_TOKEN = "__AUTH" // Auth Token
let REFRESH_TOKEN = "__TOKEN" // Refresh Token
let CALL_API = "CALL_API"
let PULL_TO_REFRESH = "Pull to refresh"
let DEFAULT_TITLE = "DEMO SIDE MENU"
let API_Timeout = 60

enum Service {
    case UNKNOWN
    case MENU_LIST
}

enum Font_Style : String {
    case Regular = ""
    case Bold = "Bold"
    case Semibold = "Semibold"
    case BoldItalic = "BoldItalic"
    case Light = "Light"
    case LightItalic = "LightItalic"
    case SemiboldItalic = "SemiboldItalic"
}

let Font_Family  = "OpenSans"


let NoInternet = "You currently do not have an internet connection. Please connect your device with the internet."
let FailedToConnect = "FAILED TO CONNECT!"
let tryAgainText = "TRY AGAIN"
let isContentAvaiable = "content-available"

let DEVICE_WIDTH :Int =  Int(UIScreen.main.bounds.size.width)
let DEVICE_HEIGHT:Int =  Int(UIScreen.main.bounds.size.height)
let DEVICE_SIZE  =  UIScreen.main.bounds.size

let SCREEN_MAX_LENGTH = max(DEVICE_WIDTH, DEVICE_HEIGHT)
let SCREEN_MIN_LENGTH = min(DEVICE_WIDTH, DEVICE_HEIGHT)
var LEFT_DRAWER_SIZE_RATIO:CGFloat = (UIScreen.main.bounds.size.width*75/100) // UIScreen.main.bounds.size.width/(375/210)
let RIGHT_DRAWER_SIZE_RATIO:CGFloat =  (UIScreen.main.bounds.size.width*75/100)
var LEFTMENUTEXT_LEADING :CGFloat = (UIScreen.main.bounds.size.width - (290*UIScreen.main.bounds.size.width)/320)/2 //+ 5.0

let SF: Float = Float(SCREEN_MIN_LENGTH)/Float(375.0)
let SF_PAD: Float = IS_DEVICE_IPHONE ? Float(SCREEN_MIN_LENGTH)/Float(375.0) : Float(SCREEN_MAX_LENGTH)/Float(667.0)
let SF_CONS: Float = IS_DEVICE_IPHONE ? Float(SCREEN_MIN_LENGTH)/Float(375.0) : Float(SCREEN_MIN_LENGTH)/Float(500.0)
let buttonCornerRatio = (UIScreen.main.bounds.size.width/(375/38))/2

let StatusBarHeight :CGFloat = IS_IPHONE_5_OR_LESS ?  20.0 : 0.0
let yGap :CGFloat = 0.0

let MenuRowHeight :CGFloat = CGFloat(28*SF)
let NavBarBottomShadowSize :CGFloat = 4.0
let ProfileImageCornerRadious :CGFloat = 5.0

let IS_DEVICE_IPHONE = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let IS_IPHONE_5_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH <= 568

let APP_BAR_BG_COLOR = "00b7e9"
let Menu_BG_COLOR = "eeeeee"
let Menu_Active_BG = "00b7e9"
let MENU_TEXT_COLOR = "4d4d4e"

let PROGRESS_MOVE_COLOR = "049bc6"
let PROGRESS_MOVE_BG = "a0cad6"

let Page_Title_Font = "Dosis-Bold"
let Page_Title_Font_LIGHT = "Dosis-Light"
let Page_Title_Font_BOOK = "Dosis-Book"
let Page_Title_Font_SEMI_BOLD = "Dosis-SemiBold"
let NoNetworkViewColor = "eb1162"
let StatusBarCOlor = "8e8d8d"

let Page_Title_Font_SIZE :CGFloat = CGFloat(20*SF)
let Menu_SIZE :CGFloat = CGFloat(18.5*SF)

