//
//  Consatnts.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//


import Foundation
import UIKit
//import GoogleSignIn

struct ConstantString {
    static let k_EMPTY:String = ""
    static let k_ZERO:String  = "0"
    static let k_ONE:String  = "1"
    static let k_TWO:String  = "2"
    static let k_EMPTY_SINGLE_SPACE:String = ""
    static let k_SINGLE_SPACE:String = " "
    static let k_Percentage_20:String = "%20"
    static let k_HYPHEN = "-"
    
    static let K_LANGUAGE_EN                                =  "en"
    static let K_LANGUAGE_AR                                =  "ar"

    static let k_EMAIL              =  "email"
    static let k_PASSWORD           =  "password"
    
    static let k_FIRST_NAME             =  "first_name"
    static let k_LAST_NAME              =  "last_name"
    static let k_GENDER                 =  "gender"
    static let k_NATIONALITY_ID         =  "nationality_id"
    static let k_PASSWORD_CONFIRMATION      =  "password_confirmation"
    static let k_TERMS_CONDITIONS       =  "terms_conditions"
 
    static let k_OTP       =  "otp"
    static let k_PAGE       =  "page"
    static let k_SEARCH       =  "search"
    static let k_LEAGUE_ID_ARRAY       =  "league_id[]"
    static let k_FAV_PLAYER      =  "favorite_players"
    static let k_FAV_TEAMS       =  "favorite_teams"
    static let k_RECORD_ID_ARRAY       =  "record_id[]"
    static let k_TEAM_ID_ARRAY       =  "team_id[]"
    static let k_COMPETITION_ID = "competition_id"
    static let k_TYPE       =  "type"
    static let k_COUNTRY       =  "country"
    static let k_PLAYER_ID = "player_id"
    static let k_NAME = "name"
    static let k_OS_TYPE = "ios"
    static let k_UID = "uid"
    static let k_TOKEN = "token"
    static let k_CHECKSUM = "checksum"
    static let k_PROFILE_IMAGE = "profile_image"
    static let k_RECEIPT = "receipt"
    static let k_VERSION = "version"

    // MARK: Microsoft Login
    // Created with the account dev.appstation@outlook.com
    static let kClientID = "02d1ddb2-4a4c-4d18-9dc0-00174b49a086"
    static let kGraphEndpoint = "https://graph.microsoft.com/"
    static let kAuthority = "https://login.microsoftonline.com/consumers"
    static let kRedirectUri = "msauth.com.applab.AmiriDiwan://auth"
    
    static let kScopes: [String] = ["user.read"]
    
    // MARK: Google Login
    // Created with the account contact@hasan.at
    static let kGoogleClientId = "303089165388-a884abh6bddn1fjac7tmo1nqijmofu9d.apps.googleusercontent.com" // Taken from FanStat (LIVE account firebase.applab@gmail.com)
//    static let signInConfig = GIDConfiguration(clientID: kGoogleClientId)
    
    // MARK: Facebook Login
    // Created with the account sreelekshmi@applab.qa
    static let kFBScopes: [String] = ["public_profile", "email"]
    
    static let k_APP_SECRET = "5ad0540737ac4461f46fd77f68561f16"
    
#if DEV
    static let key256   = "F2D5F8279A71C7D98C26E906B34908DC"   // 32 bytes for AES256
    static let iv       = "E4DD4CE68349E72C"                   // 16 bytes for AES128
#elseif STAGING
    static let key256   = "BF4CFD0E709B35131511E2D67CF2C4EE"   // 32 bytes for AES256
    static let iv       = "84F2F5393562A59B"                   // 16 bytes for AES128
#else
    static let key256   = "F2D5F8279A71C7D98C26E906B34908DC"   // 32 bytes for AES256
    static let iv       = "A97B42792251D9D6"                   // 16 bytes for AES128
#endif
}

struct ConstantStatus {
    #if DEV
        static let k_IS_AES_ENABLED = true
    #elseif STAGING
        static let k_IS_AES_ENABLED = true
    #else
        static let k_IS_AES_ENABLED = true
    #endif
}

struct ConstantAPI {
//    static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://amiridiwan.applab.qa" : "https://fanstat.app"
    //static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://api.fanstat.app/dev" : "https://fanstat.app" // New Dev URL update
    
    #if DEV
        static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://api.fanstat.app/dev" : "https://api.fanstat.app" // New Dev URL update
    #elseif STAGING
        static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://api.fanstat.app/stg" : "https://api.fanstat.app" // New Dev URL update
    #else
        static let k_ROOT_WEBSERVICE:String = Config.isAppDevelopment ? "https://mocki.io/v1/5e950519-b7a8-407c-bc7f-f6477d59a7a1"
 :  "https://mocki.io/v1/5e950519-b7a8-407c-bc7f-f6477d59a7a1"
 // New Dev URL update
    #endif
    static let k_GET_SERVICES = ""
    
    
    static let k_REQUEST_BOUNDARY:String = "---011000010111000001101001"
    static let k_REQUEST_TYPE_GET:String = "GET"
    static let k_REQUEST_TYPE_POST:String = "POST"
    static let k_REQUEST_TYPE_DELETE:String = "DELETE"
    
   

}

struct constantApiKey {
    
    //App Api Header - token
    static let KEY_APP_DEVICE_TOKEN     =  "device_token"
    static let KEY_API_TOKEN            =  "access_token"
    static let KEY_API_BEARER_TOKEN     =  "bearer_token"
    static let KEY_API_USER             =  "user"
    static let KEY_API_OS_TYPE          =  "os_type"
}

struct ConstantErrorString {
    static let k_CHECK_INTERNET             = "Please check the internet availability"
    static let k_ERROR                      = "An error occurred, please try again later"
    static let k_404                        = "Details not found. Pleaes try after some time"
    //AppController
    static let k_NO_INTERNET                = "No Internet, Please check"
}

struct ConstantDateFormat {
    static let dd                           = "dd"
    static let MM                           = "MM"
    static let MMM                          = "MMM"
    static let yyyy                         = "yyyy"
    static let EEE                          = "EEE"
    
    static let dd_MMM                       = "dd MMM"
    
    static let dd_MMM_yyyy                  = "dd MMM yyyy"
    static let dd_MM_yyyy_slashJoined       = "dd/MM/yyyy"
    static let yyyy_MM_dd                   = "yyyy-MM-dd"
    
    static let yyyy_MM_dd_HH_mm_ss          = "yyyy_MM_dd_HH_mm_ss"
    static let YYYY_MM_dd_HH_mm_ssWithColon = "YYYY-MM-dd HH:mm:ss"
    static let EEEE_dd_MMMM_YYYY            = "EEEE-dd-MMMM-YYYY"
}

struct ConstantValues {
    //static let k_ACTIVITY_LEVEL_SCALE_VERYACTIVE:Float =  1.9
    
}

class Config {
    static var isAppDevelopment:Bool { //Change url(dev or live) in the Widget_Constance class too for widget
        return true
//        get {
//            if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
//                if let dic = NSDictionary(contentsOfFile: path)  {
//                    return dic["IS_APP_DEVELOPMENT"] as? Bool ?? true
//                }
//            }
//            return true
//        }
    }
    
    static var renderLable:Bool {
        get {
            if (UIDevice.current.identifierForVendor != nil){
                return true
            }else{
                return false
            }
        }
    }
}


