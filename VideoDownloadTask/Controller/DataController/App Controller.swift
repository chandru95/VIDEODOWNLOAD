//
//  App Controller.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

//import Foundation
//import Foundation
//import SJFrameSwift
//
//enum AppTheme:String {
//    case light
//    case dark
//    case unspecified
//}
//public class AppController {
//    var storageUserDataFileName = "UserData.objc"
//
//    static let shared = AppController()
//    var interAppCommunication:InterAppCommunication?
//    
//   
//    
//    init() {
//        
//        addLocalisedLanguages()
//        
//        //Loader View
//        SJFrame.settings.isHaveRTL = true
//        SJFrame.settings.loaderViewBackgroundColor =  UIColor(red: 57/255, green: 190/255, blue: 227/255, alpha: 0.1)
//        SJFrame.settings.loaderBackgroundColor = UIColor.white
//        SJFrame.settings.loaderStrokeColor = UIColor(rgb: 0xE75E16)
//        SJFrame.settings.setLoaderSize(size: 70)
//        SJFrame.settings.setLoaderIconSize(size:60)
//        SJFrame.settings.setloaderStrokeWidth(width:2)
//    }
//    
//    //MARK: - Defaults
//    var isAppLaunchedBefore:Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "isAppLaunchedBefore")
//        }
//        set (newValue) {
//            UserDefaults.standard.set(newValue, forKey: "isAppLaunchedBefore")
//        }
//    }
//    
//    // MARK: Localisation
//    func addLocalisedLanguages() ->Void{
//        let english:SJLocale = SJLocale("English(EN)", _countryName: "United Kingdom", _languageCode: "en", _countryCode: "gb");
//        let arabic:SJLocale = SJLocale("Arabic(AR)", _countryName: "Arabic", _languageCode: "ar", _countryCode: "ar");
//        
//        SJLocalisedString.addLocalisedLanguage(local: english);
//        SJLocalisedString.addLocalisedLanguage(local: arabic);
//    }
//    
//    func setAppLanguage(objLanguage:SJLocale?) -> Void {
//        if let lang = objLanguage{
//            SJLocalisedString.setLanguage(local: lang);
//        }else{
//            SJLocalisedString.setDefaultLanguage();
//        }
//    }
//    
//    func isAppLanguageArabic() -> Bool {
//        var status = false;
//        guard let objLocalLanguage:SJLocale = SJLocalisedString.getSelectedLocale() else{
//            return status;
//        }
//        if(objLocalLanguage.languageCode?.lowercased() == "ar"){
//            status = true;
//        }
//        return status;
//    }
//    func getDeviceTimezone() -> String {
//        let timeZone = UserDefaults.standard.value(forKey: "DEVICE_TIME_ZONE") as? String ?? ConstantString.k_EMPTY
//        if timeZone.count == 0 {
//            return TimeZone.current.identifier
//        }
//        return UserDefaults.standard.value(forKey: "DEVICE_TIME_ZONE") as? String ?? ConstantString.k_EMPTY
//    }
//    
//    func toggleAppGUILanguage() -> Void {
//        if(isAppLanguageArabic()){
//            let english:SJLocale = SJLocale("English(EN)", _countryName: "United Kingdom", _languageCode: "en", _countryCode: "gb");
//            SJLocalisedString.setLanguage(local: english)
//        }else{
//            let arabic:SJLocale = SJLocale("Arabic(AR)", _countryName: "Arabic", _languageCode: "ar", _countryCode: "ar");
//            SJLocalisedString.setLanguage(local: arabic);
//        }
//        //        NotificationCenter.default.post(name: NSNotification.Name.appLanguageChange, object: nil);
//        
//    }
//    
//    // MARK: Logout & Clear
//    
//    
//    func clearLoggedUserData(){
//        SJDataCache.store(Data(), to: .documents, as: storageUserDataFileName)
//    }
//    
////    func deleteAppleCredentials() {
////        do {
////            try KeychainItem(account: KeychainItem.UserIdentifierAccount.identifier.rawValue).deleteItem()
////            try KeychainItem(account: KeychainItem.UserIdentifierAccount.firstName.rawValue).deleteItem()
////            try KeychainItem(account: KeychainItem.UserIdentifierAccount.lastName.rawValue).deleteItem()
////            try KeychainItem(account: KeychainItem.UserIdentifierAccount.email.rawValue).deleteItem()
////            print("deleteUserInKeychain :: userIdentifier deleted from keychain")
////        } catch {
////            print("Unable to delete userIdentifier to keychain.")
////        }
////    }
//    
//    
//    var appTheme: UIUserInterfaceStyle {
//        get {
//            if let savedThems = UserDefaults.standard.value(forKey: "APP_THEME") as? String {
//                let theme = AppTheme(rawValue: savedThems)
//                if theme == .light {
//                    return UIUserInterfaceStyle.light
//                } else if theme == .dark {
//                    return UIUserInterfaceStyle.dark
//                }
//                return UIUserInterfaceStyle.light
//            }
//            return UIUserInterfaceStyle.light
//        }
//        set (newValue) {
//            var theme = AppTheme.unspecified
//            if newValue == .light {
//                theme = AppTheme.light
//            } else  if newValue == .dark {
//                theme = AppTheme.dark
//            }
//            UserDefaults.standard.set(theme.rawValue, forKey: "APP_THEME")
//            NotificationCenter.default.post(name: NSNotification.Name.themeChanged, object: nil)
//        }
//    }
//    
//    
//}
//
//// MARK: - CUSTOM FONT
//class AppFont{
//    
//    enum FontType {
//        case extraBold
//        case bold
//        case semibold
//        case medium
//        case regular
//        case light
//    }
//    
//    class func get(type:FontType,size:CGFloat) -> UIFont {
//        
//        let isArabic = AppController.shared.isAppLanguageArabic();
//        switch type {
//        case FontType.extraBold:
//            return (isArabic ? UIFont(name: "Cairo-Black", size: size) : UIFont(name: "Cairo-Black", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.bold:
//            return (isArabic ? UIFont(name: "Cairo-Bold", size: size) : UIFont(name: "Cairo-Bold", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.semibold:
//            return (isArabic ? UIFont(name: "Cairo-SemiBold", size: size) : UIFont(name: "Cairo-SemiBold", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.medium:
//            return (isArabic ? UIFont(name: "Cairo-SemiBold", size: size) : UIFont(name: "Cairo-SemiBold", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.regular:
//            return (isArabic ? UIFont(name: "Cairo-Regular", size: size) : UIFont(name: "Cairo-Regular", size: size)) ?? UIFont.systemFont(ofSize: size)
//        case FontType.light:
//            return (isArabic ? UIFont(name: "Cairo-Light", size: size) : UIFont(name: "Cairo-Light", size: size)) ?? UIFont.systemFont(ofSize: size)
//        }
//    }
//    
//    class func getEnglish(type:FontType,size:CGFloat) -> UIFont {
//         
//        switch type {
//        case FontType.extraBold:
//            return UIFont(name: "Cairo-Black", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.bold:
//            return UIFont(name: "Cairo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.semibold:
//            return UIFont(name: "Cairo-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.medium:
//            return UIFont(name: "Cairo-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.regular:
//            return UIFont(name: "Cairo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.light:
//            return UIFont(name: "Cairo-Light", size: size) ?? UIFont.systemFont(ofSize: size)
//        }
//    }
//    
//    class func getArabic(type:FontType,size:CGFloat) -> UIFont {
//        switch type {
//        case FontType.extraBold:
//            return UIFont(name: "Cairo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.bold:
//            return UIFont(name: "Cairo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.semibold:
//            return UIFont(name: "Cairo-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.medium:
//            return UIFont(name: "Cairo-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.regular:
//            return UIFont(name: "Cairo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
//        case FontType.light:
//            return UIFont(name: "Cairo-Light", size: size) ?? UIFont.systemFont(ofSize: size)
//        }
//    }
//    
//    
//    class func getTextAlignment() -> NSTextAlignment{
//        let isArabic = AppController.shared.isAppLanguageArabic();
//        if(isArabic){
//            return NSTextAlignment.right;
//        }else{
//            return NSTextAlignment.left;
//        }
//    }
//    
//}
//
//struct InterAppCommunication {
//    var verificationId:String?// = "123456"//vc
//    var newsId:String?
//    var notificationId:String? = "123456"
//    
//    init(_ dict:[String:Any]) {
//        if let value = dict["newsId"] as? String{
//            newsId = value
//        }else if let value = dict["notificationId"] as? String{
//            notificationId = value
//        }else if let value = dict["verificationId"] as? String{
//            verificationId = value
//        }
//    }
//}
//
//// MARK: - INTER APP COMMUNICATION
////class InterAppCommunicationController {
////
////    var strNotificationRequestId:String?
////
////    func isAppCustomURLSchem(URLOfDeeplink:String?) -> Bool {
////
////        guard let deepLink = URLOfDeeplink else{
////            return false;
////        }
////        if(deepLink == ConstantString.k_EMPTY){
////            return false;
////        }
////
////
////        return false;
////    }
////
////
////    func isHaveInterAppNavigations() -> Bool {
////        var status = false;
////        if((strNotificationRequestId != nil && strNotificationRequestId != ConstantString.k_EMPTY)){
////            status = true;
////        }
////        else{
////            status = false;
////        }
////        return status;
////    }
////}
//
//
//
//extension Notification.Name {
//    static let appEnterForeground = Notification.Name("EnterForeground")
//    static let appEnterBackground = Notification.Name("EnterBackground")
//    static let appLanguageChange  = Notification.Name("appLanguageChange")
//    static let appShowHeaderMessage = Notification.Name("appShowHeaderMessage")
//    static let enableScroll = Notification.Name("enableScroll")
//    static let disableScroll = Notification.Name("disableScroll")
//    static let performLogout = Notification.Name("performLogout")
//    static let focusFavoriteTab = Notification.Name("focusFavoriteTab")
//    static let addFavourites = Notification.Name("addFavourites")
//    static let showSignInAlert = Notification.Name("showSignInAlert")
//    static let themeChanged = Notification.Name("themeChanged")
//    static let homeProfileIconTapped = Notification.Name("homeProfileIconTapped")
//    static let DeepLinkNavigation   =   Notification.Name("DeepLinkNavigation");
//    static let DeepLinkNavigationFromBg = Notification.Name("DeepLinkNavigationFromBg");
//    static let updateUserInfo   =   Notification.Name("updateUserInfo");
//    static let receivedPushNotificationPlayer = Notification.Name("receivedPushNotificationPlayer")
//    static let receivedPushNotificationCompetition = Notification.Name("receivedPushNotificationCompetition")
//    static let updateApi = Notification.Name("updateApi")
//
//
//}
//
//
//extension Bundle {
//    var releaseVersionNumber: String? {
//        return infoDictionary?["CFBundleShortVersionString"] as? String
//    }
//    var buildVersionNumber: String? {
//        return infoDictionary?["CFBundleVersion"] as? String
//    }
//    var releaseVersionNumberPretty: String {
//        return "v\(releaseVersionNumber ?? "1.0.0")"
//    }
//}
//
//
////MARK: Api Call - Login
//extension AppController {
////    func callGetCountriesAPI(completion:((_ countryCodes:[Country])->Void)?) -> Void {
////        if AppController.shared.checkInternetAvailability() {
////            let nwctrl = APINetworkController()
////            let objRequest = AppBaseRequest(ConstantAPI.WEBSERVICE_GET_COUNTRIES ,ConstantAPI.k_REQUEST_TYPE_GET)
////
////            nwctrl.callWebserviceRequest(objRequest) { (objResult) in
////                if let result = objResult.resultData as? [[String:Any]] {
////                    self.countries = []
////                    for country in result {
////                        let countryModel = Country(country)
////                        if countryModel.code.count > 0 {
////                            self.countries.append(countryModel)
////                        }
////                    }
////                    if let completion = completion { completion(self.countries) }
////                }else {
////                    if let completion = completion { completion([]) }
////                }
////            }
////        }else{
////            if let completion = completion { completion([]) }
////        }
////    }
//    
////    func updateDeviceTokenInServer(){
////        print("Called ::: updateDeviceTokenInServer |\(AppController.shared.getDevicePushToken())|")
////        if AppController.shared.checkInternetAvailability() {
////            if AppController.shared.getDevicePushToken().count == 0 { return }
////            let nwctrl = APINetworkController()
////            let objRequest = AppBaseRequest(ConstantAPI.WEBSERVICE_UPDATE_PUSH_TOKEN ,ConstantAPI.k_REQUEST_TYPE_POST)
////            objRequest.addParam(key: constantApiKey.KEY_APP_DEVICE_TOKEN, value: AppController.shared.getDevicePushToken())
////            objRequest.addParam(key: constantApiKey.KEY_API_OS_TYPE, value: ConstantString.k_OS_TYPE)
////
////            nwctrl.callWebserviceRequest(objRequest) { (objResult) in
////                if objResult.api_status {
////                    print("TOKEN UPDATATED TO SERVER")
////                }else {
////                    print("updateDeviceTokenInServer :: no results")
////                }
////            }
////        }
////    }
//    
////    func callFirstPageMatchesListAPIForImageCache() {
////        if AppController.shared.checkInternetAvailability() {
////            let nwctrl = APINetworkController()
////            var urlString = ConstantAPI.WEBPAGE_COMPETITION_LIST
////            urlString = urlString+"?\(ConstantString.k_PAGE)=\(ConstantString.k_ONE)"
////            let objRequest = AppBaseRequest(urlString ,ConstantAPI.k_REQUEST_TYPE_GET)
////            nwctrl.callWebserviceRequest(objRequest) { (objResult) in
////                if let result = objResult.resultData as? [String:Any], objResult.api_status == true {
////                    print("result ====> \(result)")
////                    DispatchQueue.main.async {
////                        let competitionListResponse = CompetitionListResponse(result)
////                        for competition in competitionListResponse.data {
////                            if let url = URL(string: competition.logo.spaceRemoved()) {
////                                JMImageCache.shared().cachedImage(for: url)
////                                print("callFirstPageMatchesListAPIForImageCache :: ====> \(url)")
////                            }
////                        }
////                    }
////                }else {
////
////                }
////            }
////        }else{
////
////        }
////    }
//}
//
//
//
//
//
