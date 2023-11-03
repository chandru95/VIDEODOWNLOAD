//
//  ApiNetworkController.swift
//  VideoDownloadTask
//
//  Created by Alen c james on 22/09/23.
//

import UIKit
import Foundation
import AdSupport
import SJFrameSwift

class AppBaseRequest: SJRequest {
    
    public init(_ subAPIURL:String,_ method:String){
        super.init(method);
        subURL = subAPIURL;
        
//        if AppController.shared.isAppLanguageArabic(){
//            self.addParam(key: "language", value: "ar");
//        }else{
//            self.addParam(key: "language", value: "en");
//        }
        
        
    }
}


public class SJRequest:NSObject{
    var rootURL     = ConstantAPI.k_ROOT_WEBSERVICE; // + "?lang=an";
    var subURL      = ConstantString.k_EMPTY;
    var method      = ConstantAPI.k_REQUEST_TYPE_GET;
    var param       = [[String:Any]]();
    var rawParam:String = ConstantString.k_EMPTY
    
    public init(_ _method:String) {
        super.init();
        self.method = _method;
    }
    
    convenience public init(_ _subURL:String,_ _method:String) {
        self.init(_method)
        self.subURL = _subURL;
    }
    
    func addParam(key:String,value:String) -> Void {
        let obj = ["name":key,"value":value]
        self.param.append(obj);
    }
    
    func addParam(key:String,valueInt:Int) -> Void {
        let obj = ["name":key,"value":valueInt] as [String : Any]
        self.param.append(obj);
    }
    
    func addImageParam(key:String,value:Data) -> Void {
        let obj = ["name":key,"value":value] as [String : Any]
        self.param.append(obj);
    }
    func getFileName()->String{
        let random = 100+arc4random()%900
        return "\(Date().timeIntervalSinceNow)".replacingOccurrences(of: ".", with: "_")+"\(random)"
    }
    func mimeTypeAndFileName(for data: Data) -> (String,String) {
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        print("Mime type ====> \(b)")
        switch b {
        case 0xFF:
            return ("image/jpeg","\(getFileName()).jpeg")
        case 0x89:
            return ("image/png","\(getFileName()).png")
        case 0x47:
            return ("image/gif","\(getFileName()).gif")
        case 0x4D, 0x49:
            return ("image/tiff","\(getFileName()).tiff")
        case 0x25:
            return ("application/pdf","\(getFileName()).pdf")
        case 0xD0:
            return ("application/vnd","\(getFileName()).vnd")
        case 0x46:
            return ("text/plain","\(getFileName()).txt")
        case 0x3B:
            return ("application/doc","\(getFileName()).doc")
        default:
            return ("application/octet-stream","\(getFileName()).m4a")
        }
        //        switch b {
        //        case 0xFF:
        //            return ("image/jpeg","sample.jpeg")
        //        case 0x89:
        //            return ("image/png","sample.png")
        //        default:
        //            return ("application/octet-stream","sample.m4a")
        //        }
    }
    
    func getBodyData() -> Data? {
        if !rawParam.isEmpty {
            print("Having rawParam...\(rawParam)")
            let postData = rawParam.data(using: .utf8)
            return postData
        }
        let body = NSMutableData();
        for param in self.param {
            let paramName = param["name"]!
            body.append("--\(ConstantAPI.k_REQUEST_BOUNDARY)\r\n".data(using: String.Encoding.utf8)!);
            //body += "--\(ConstantAPI.k_REQUEST_BOUNDARY)\r\n"
            //body += "Content-Disposition:form-data; name=\"\(paramName)\""
            
            body.append("Content-Disposition:form-data; name=\"\(paramName)\"".data(using: String.Encoding.utf8)!);
            
            if let paramValue = param["value"] {
                
                if(paramValue is Data){
                    let uploadedFileSpecs = self.mimeTypeAndFileName(for: paramValue as! Data)
                    let mimeType = uploadedFileSpecs.0
                    let fileName = uploadedFileSpecs.1
                    print("mimeType====> \(mimeType)")
                    print("mimeType====> \(mimeType)")
                    
                    //if let fileContent = String(data: paramValue as! Data, encoding: String.Encoding.utf8){
                    
                    //body += "; filename=\"\(paramName)\"\r\n"
                    body.append("; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!);
                    //body += "Content-Type: image/png \r\n\r\n"
                    body.append("Content-Type: \(mimeType) \r\n\r\n".data(using: String.Encoding.utf8)!);
                    //body += fileContent;
                    body.append(paramValue as! Data);
                    body.append("\r\n".data(using: String.Encoding.utf8)!)
                    body.append("--\(ConstantAPI.k_REQUEST_BOUNDARY)\r\n".data(using: String.Encoding.utf8)!);
                    //}
                }else{
                    //body += "\r\n\r\n\(paramValue)\n"
                    body.append("\r\n\r\n\(paramValue)\n".data(using: String.Encoding.utf8)!);
                }
            }
            
        }
       
        return body as Data;
    }
    
}


struct SJResponse{
    var api_status:Bool = false;
    var errorMsg:String = "";
    var resultData:Any?
    var errors:Any?
    var verified:Bool?
    
    mutating func initialize(message:String = "API Error") -> Void {
        api_status = false;
        
        /*
         do {
         resultData = try JSONSerialization.data(withJSONObject: ["error":message] as [String:String], options: .prettyPrinted)
         } catch {
         print(error.localizedDescription)
         }
         */
        errors = message;
    }
    
    mutating func initialize(_error:Any) -> Void {
        api_status = false;
        
        /*
         do {
         resultData = try JSONSerialization.data(withJSONObject: ["error":message] as [String:String], options: .prettyPrinted)
         } catch {
         print(error.localizedDescription)
         }
         */
        errors = _error;
    }
    
    init(_errors:Any){
        api_status = false;
        errors = _errors;
        //errorMsg = ""
    }
    
    init(data:Data) {
        
        do {
            guard let receivedTodo = try JSONSerialization.jsonObject(with: data,
                                                                      options: []) as? [String: Any] else {
                print("Could not get JSON from responseData as dictionary")
                self.initialize();
                return
            }
            print("The todo is: " + receivedTodo.description)
            
            guard let apiResponds = receivedTodo["Response"] as? [String:Any] else{
                
                self.initialize();
                return;
            }
            print("The todo is: " + apiResponds.description)
            guard let status = apiResponds["status"] else {
                self.initialize();
                return;
            }
            
            
            if let errorMsgValue:String = apiResponds["message"] as? String {
                errorMsg = errorMsgValue
            }
            if status is String{
                api_status = ((status as! String) == "1" ? true : false)
            }else if status is Int{
                api_status = ((status as! Int) == 1 ? true : false)
            }else if status is Bool{
                api_status = status as! Bool
            }else{
                self.initialize();
                return
            }
            
            if(api_status) {
                /*
                 guard let result = apiResponds["result"] as? [String:Any] else {
                 self.initialize();
                 return;
                 }
                 
                 if let message = apiResponds["message"] as? String {
                 if message != ""{
                 self.initialize(message: message);
                 return;
                 }
                 }*/
                //print("The todo is: " + result.description)
                // resultData = result//try JSONSerialization.data(withJSONObject: apiResponds, options: .prettyPrinted);
                
                if let result = apiResponds["result"] as? [String:Any]{
                    resultData = result
                }else if let result = apiResponds["result"] as? [[String:Any]] {
                    resultData = result
                }else if let message = apiResponds["message"] as? String{
                    resultData = ["message":message]
                }else{
                    self.initialize();
                }
            }else{
                if let result = apiResponds["result"] as? [String:Any] {
                    if let verified = result["verified"] as? Bool {
                        self.verified = verified
                    }
                }
                
                if let errors = apiResponds["errors"]{
                    self.initialize(_error: errors);
                }else{
                    self.initialize();
                }
            }
            
            
        } catch  {
            print("error parsing response from POST on /todos")
        }
    }
}

public class APINetworkController: NSObject {
    
    func callWebserviceRequest(_ objRequest:SJRequest, Completion:((_ objResponse:SJResponse)->Void)?) -> Void {
        
//        if !AppController.shared.checkInternetAvailability(){
//            Completion?(SJResponse(_errors: SJLocalisedString["key_Check_internet"]));
//            return
//        }
        
        if let subUrl = URL(string: objRequest.subURL){
            objRequest.rootURL = "\(objRequest.rootURL)\(subUrl.absoluteString)"
        }
        
        /**
         START
         Added for removing url path for the new DEV server
         */
        if objRequest.rootURL.contains("https://api.fanstat.app/dev") { //TODO
            //objRequest.rootURL = objRequest.rootURL.replacingOccurrences(of: "/api/v1", with: "")
        }
        // END
        
        guard let todosURL = URL(string: objRequest.rootURL) else {
            print("Error: cannot create URL")
            return
        }
        
        
        
        guard (objRequest.method as String?) != nil else {
            print("Error: request method error")
            return
        }
        
        let todosUrlRequest = NSMutableURLRequest(url: todosURL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 30.0)
        
        todosUrlRequest.httpMethod = objRequest.method;
        
        
        /*
         let cookieHeader = (newTodo.compactMap({ (key, value) -> String in
         return "\(key)=\(value)"
         }) as Array).joined(separator: "&")
         */
        
        let token = "Bearer "
//        if let authorization = AppController.shared.getAuthorizationToken(),!authorization.isEmpty{
//            token = token+authorization
//        }
        
//        var lang = "en"
//
//        if AppController.shared.isAppLanguageArabic(){
//            lang = "ar"
//        }
//
//        let timezone = AppController.shared.getDeviceTimezone() //eg: "Asia/Kolkata"
//        var appTheme = "light"
//        if AppController.shared.appTheme == .light {
//            appTheme = "light"
//        }else {
//            appTheme = "dark"
//        }
        
//        var headers = [
//            "content-type": "multipart/form-data; boundary=\(ConstantAPI.k_REQUEST_BOUNDARY)",
////            "Authorization":token,
//            "LANG":lang,
//            "time-zone":timezone,
//            "Accept":"application/json",
//            "mode":appTheme
//        ]
        
//        if objRequest.subURL == ConstantAPI.WEBSERVICE_IAP_SUBSCRIPTION {
//            headers = [
//                "Content-Type": "application/json",
//                "Authorization":token,
//                "LANG":lang,
//                "time-zone":timezone,
//                "Accept":"application/json",
//                "mode":appTheme
//            ]
//        }
        
        //MARK: - AES Encrypted payload
//        if ConstantStatus.k_IS_AES_ENABLED {
//            if objRequest.rootURL.contains("login") || objRequest.rootURL.contains("register") || objRequest.rootURL.contains("verify-email") || objRequest.rootURL.contains("resend-email") ||
//                objRequest.rootURL.contains("verify-password") || objRequest.rootURL.contains("resend-password") {
//                headers["encrypted"] = "true"
//                headers["Content-Type"] = "text/plain"
//                headers["content-type"] = "text/plain"
//            }
//        }
        
//        todosUrlRequest.allHTTPHeaderFields = headers
        if objRequest.method == ConstantAPI.k_REQUEST_TYPE_POST{
            todosUrlRequest.httpBody = objRequest.getBodyData(); //body.data(using: .utf8);
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest as URLRequest) {
            (data, response, error) in
//            if let httpResponse = response as? HTTPURLResponse {
//                //TODO: -
//                if (httpResponse.statusCode == 401) {
//                    print("httpResponse.statusCode ====> \(httpResponse.statusCode)")
//                    //Completion?(SJResponse(_errors: "Unauthenticated"));
//                    if objRequest.subURL != ConstantAPI.WEBSERVICE_USER_LOGIN &&
//                        objRequest.subURL != ConstantAPI.WEBSERVICE_USER_REGISTRATION &&
//                        objRequest.subURL != ConstantAPI.WEBSERVICE_VERIFY_FORGOT_PASSWORD_OTP_AND_NEW_PW &&
//                        !objRequest.subURL.contains(ConstantAPI.WEBSERVICE_SOCIAL_LOGIN) &&
//                        objRequest.subURL != ConstantAPI.WEBSERVICE_UPDATE_PUSH_TOKEN {
//                        NotificationCenter.default.post(name: .performLogout, object: nil)
//                        return
//                    }
//                }
//            }
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                Completion?(SJResponse(_errors: SJLocalisedString["key_Server_busy"]))
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                Completion?(SJResponse(_errors: SJLocalisedString["key_Server_busy"]));
                return
            }
            
            
            guard let responds = String(data: responseData, encoding:.utf8) else{
                print("Error in data"); //return;
                Completion?(SJResponse(_errors: SJLocalisedString["key_Server_busy"]));
                return
            }
            
            print(responds)
            
            
            Completion?(SJResponse(data: responseData));
            
        }
        task.resume()
    }
    
}


//let activityViewController = UIActivityViewController(activityItems: [graphScreenshot], applicationActivities: nil)
//activityViewController.popoverPresentationController?.sourceView = self.view
//self.present(activityViewController, animated: true, completion: nil)
