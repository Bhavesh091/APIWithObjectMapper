
import Foundation
import UIKit
import Alamofire
import ObjectMapper

typealias apiResponseSuccess = (_ success: DataResponse<Any>) -> Void
typealias apiResponseFailed = (_ failed: Error) -> Void
typealias apiResponseStatus = (_ Status: Bool) -> Void

private let _sharedInstance = APIClient()

class APIClient: NSObject {
    
    let storyboard:UIStoryboard = UIStoryboard.init(name: storyboardUniversal, bundle: nil)
        
    class var sharedInstance: APIClient {
        return _sharedInstance
    }
    
  func authHeader(ISAuth:Bool) -> [String : String] {
         
         var header = [String : String]()
         
//         let model = ApiUtillity.sharedInstance.getLoginModel()

        
        let data = Defaults[.Login_Response]
        let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: data)

        if let user_Api = resultModel?.loginModel?.userApi, user_Api.count != 0
         {
             header = ["X-Authorization": user_Api,
                       "Content-Type": "application/x-www-form-urlencoded"] as [String : String]
         }
         else if let user_Api = resultModel?.loginModel?.userApi, user_Api.count != 0
         {             header = ["X-Authorization": user_Api,
                     "Content-Type": "application/x-www-form-urlencoded"] as [String : String]
         }
     
         return header
     }
  
    //MARK:- JSON converter
    func prettyPrint(with json: [String:Any]) -> String {
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string! as String
    }
    
    
    //MARK:- API_GET
    func API_GET(Url:String,Params:[String : AnyObject], Authentication:Bool, mapObject:Any?, SuperVC:UIViewController, completionSuccess: @escaping apiResponseSuccess, completionFailed: @escaping apiResponseFailed) {
        
//        print( prettyPrint(with: Params))
//        print(Url)
        
        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            
            
            Alamofire.request(Url, method: .get, parameters: Params, encoding: URLEncoding.default, headers: authHeader).responseJSON
                { response in
                    //debugPrint(rexsponse)
                    guard
                        let responseJSON = response.result.value
                        
                        else {
                            print(response.error!)
                            completionFailed(response.error!)
                            return
                    }
//                    print(responseJSON)
                    
                    if response.result.value != nil
                    {
                        completionSuccess(response)
                        return
                    }
                    else
                    {
                        print(response.error)
                    }
                }.responseString { response in
                    print("-----------------------")
                    debugPrint(response)
                    print("-----------------------")
                    print(response)
            }
        }
        else
        {
            return
        }
    }
    
    // MARK:- API_POST
    
    func API_POST(Url:String,Params:[String : AnyObject],Authentication:Bool,mapObject:Any?,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionFailed: @escaping apiResponseFailed) {

        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            Alamofire.request(Url, method: .post, parameters: Params, encoding: URLEncoding.default, headers: authHeader).responseJSON
                { response in
                    
                    guard
                        response.result.value != nil
                        
                        else {
                            
                            completionFailed(response.error!)
                            return
                    }
                    if response.result.value != nil
                    {
                        completionSuccess(response)
                        return
                    }
                    else
                    {
                        print(response.error)
                    }
                }
        }
        else {
                print("error")
        }
    }
    
    
    // MARK:- API_PATCH
    
    func API_PATCH(Url:String,Params:[String : AnyObject],Authentication:Bool,mapObject:Any?,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionFailed: @escaping apiResponseFailed) {
        
        
        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            Alamofire.request(Url, method: .patch, parameters: Params, encoding: JSONEncoding.default, headers: authHeader)
                .responseJSON
                { response in
                    //                    debugPrint(response)
                    //                    print(response)
                    guard
                        let responseJSON = response.result.value

                        else {

                            completionFailed(response.error!)
                            return
                    }
                    if response.result.value != nil
                    {
                        completionSuccess(response)
                        return
                    }
                    else
                    {
                        print(response.error)
                    }
            }
        }
        else {
            
        }
    }
    
    //MARK:- API_DELETE
    func API_DELETE(Url:String,Params:[String : AnyObject],Authentication:Bool,mapObject:Any?,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionFailed: @escaping apiResponseFailed) {
        
        print( prettyPrint(with: Params))
        print(Url)
        
        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            Alamofire.request(Url, method: .delete, parameters: Params, encoding: URLEncoding.default, headers: authHeader).responseJSON
                { response in
                    
                    guard
                        let responseJSON = response.result.value
                        
                        else {
                            print(response.error!)
                            completionFailed(response.error!)
                            return
                    }
                    //                    print(responseJSON)
                    
                    if response.result.value != nil
                    {
                        completionSuccess(response)
                        return
                    }
                    else
                    {
                        print(response.error)
                    }
                    
            }
        }
        else {
            
        }
    }
    
    //MARK:- API_PUT
    func API_PUT(Url:String,Params:[String : AnyObject],Authentication:Bool,mapObject:Any?,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionFailed: @escaping apiResponseFailed) {
        
        print( prettyPrint(with: Params))
        print(Url)
        
        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            Alamofire.request(Url, method: .put, parameters: Params, encoding: URLEncoding.default, headers: authHeader).responseJSON
                { response in
                    //            debugPrint(response)
                    guard
                        let responseJSON = response.result.value
                        
                        else {
                            
                            completionFailed(response.error!)
                            return
                    }
                    if response.response != nil
                    {
                        completionSuccess(response)
                        return
                    }
            }
        }
        else {
            
        }
    }

    //MARK:- API_UPLOAD
    func API_UPLOAD(Url:String,Params:[String : AnyObject],fileName:String,fileData:Data,mimeType:String,Authentication:Bool,mapObject:Any?,SuperVC:UIViewController,completionSuccess: @escaping apiResponseSuccess,completionFailed: @escaping apiResponseFailed) {
        print(Url)
        if ApiUtillity.sharedInstance.isReachable() {
            let authHeader = self.authHeader(ISAuth: Authentication)
            let URL = try! URLRequest(url: Url, method: .post, headers: authHeader)
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(fileData, withName: "upload", fileName: fileName, mimeType: mimeType)
            }, with: URL) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })

                    upload.responseJSON { response in
                        guard
                            let responseJSON = response.result.value

                            else {
                                print(response.error!)
                                completionFailed(response.error!)
                                return
                        }
                        if response.response != nil
                        {
                            completionSuccess(response)
                            return
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        }
        else {
            let errorTemp = NSError(domain:"Please check Internet Connection", code:403, userInfo:nil)
            completionFailed(errorTemp)
            return
        }
    }

}

//Default Declared Keys
extension DefaultsKeys {
    
    //Login Params
    
    static let FCMToken = DefaultsKey<String>("FCMToken")
    static let Login_Response = DefaultsKey<[String: Any]>("Login_Response")
//    static let udk_FCM_TOKEN = DefaultsKey<String>("udk_FCM_TOKEN")
    static let isLogin = DefaultsKey<Bool>("isLogin")
    static let headerClient = DefaultsKey<String>("headerClient")
    static let headerToken = DefaultsKey<String>("headerToken")
    static let headerUID = DefaultsKey<String>("headerUID")
    
    static func defaultFCMKeyMaker(key:String) -> DefaultsKey<Int>{
        return DefaultsKey<Int>(key)
    }
}










//
//  ApiUtility.swift
//  TestApp
//
//  Created by MAC on 10/31/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos
import Alamofire
import NVActivityIndicatorView
import ObjectMapper

private let _sharedInstance = ApiUtillity()

//For Check Internate Availability
func isReachable() -> Bool {
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    return (reachabilityManager?.isReachable)!
}

class DCustomButton: UIButton {
    var indexpath: IndexPath?
}

let groupByKey:String = "key"
let groupByArray:String = "subArray"

class ApiUtillity: NSObject {
    
    class var sharedInstance: ApiUtillity {
        return _sharedInstance
    }
    
    // MARK:- GetCurrentDateTime
    
    func currentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let resultDateString = formatter.string(from: Date())
        print(resultDateString)
        return resultDateString
    }
    
    // MARK:- Get Device
    
    func is_iPhoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            switch Int(UIScreen.main.nativeBounds.size.height) {
             
            case 2436:
                print("iPhone X")
                return true
            default:
                print("unknown")
                return false
            }
        }
        return false
    }

    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func notPrettyString(from object: Any) -> String? {
        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions(rawValue: 0)) {
            let objectString = String(data: objectData, encoding: .utf8)
            return objectString
        }
        return nil
    }
    
    func prettyPrint(with json: [String:Any]) -> String{
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string! as String
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    // For Get Color Using HexCode
    func getColorIntoHex(Hex:String) -> UIColor {
        if Hex.isEmpty {
            return UIColor.clear
        }
        let scanner = Scanner(string: Hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        return UIColor.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
    
    //For Check Internate Availability
    func isReachable() -> Bool
    {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
        return (reachabilityManager?.isReachable)!
    }
    
    //Image Color Change
    func setImageColor(obj:Any, ImageName imagename:String,Color color:UIColor) {
        if obj is UIButton {
            let tempView:UIButton = obj as! UIButton
            let image :UIImage = UIImage(named: imagename)!
            tempView.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            tempView.tintColor = color
        }
        if obj is UIImageView {
            let tempView:UIImageView = obj as! UIImageView
            let image :UIImage = UIImage(named: imagename)!
            tempView.image = image.withRenderingMode(.alwaysTemplate)
            tempView.tintColor = color
        }
    }
    
    
    func AddSubViewtoParentView(parentview: UIView! , subview: UIView!)
    {
        subview.translatesAutoresizingMaskIntoConstraints = false
        parentview.addSubview(subview);
        parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0))
        parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: 0.0))
        parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0.0))
        parentview.addConstraint(NSLayoutConstraint(item: subview!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: parentview, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: 0.0))
        parentview.layoutIfNeeded()
    }
    
    func getRowsforList(_ tableCollectionView: Any, forArray arrayCount: Int, withPlaceHolder strPlaceHolder: String) -> Int {
        if (tableCollectionView is UITableView) {
            let tableView = tableCollectionView as? UITableView
            if tableView?.tag != 0 && arrayCount == 0 {
                let noDataMessage = UILabel(frame: CGRect(x: 0, y: 0, width: (tableView?.bounds.size.width)!, height: (tableView?.bounds.size.height)!))
                noDataMessage.text = strPlaceHolder
                noDataMessage.textColor = UIColor.darkGray
                noDataMessage.textAlignment = .center
                tableView?.backgroundView = noDataMessage
            }
            else {
                tableView?.backgroundView = nil
            }
        }
        if (tableCollectionView is UICollectionView) {
            let collectionView = tableCollectionView as? UICollectionView
            if collectionView?.tag != 0 && arrayCount == 0 {
                let noDataMessage = UILabel(frame: CGRect(x: 0, y: 0, width: (collectionView?.bounds.size.width)!, height: (collectionView?.bounds.size.height)!))
                noDataMessage.text = strPlaceHolder
                noDataMessage.textColor = UIColor.darkGray
                noDataMessage.textAlignment = .center
                collectionView?.backgroundView = noDataMessage
            }
            else {
                collectionView?.backgroundView = nil
            }
        }
        return arrayCount
    }
    
    // Set Language Data
    func setLanguageData(data:NSMutableDictionary) {
        var Dic:NSMutableDictionary = NSMutableDictionary()
        Dic = data.mutableCopy() as! NSMutableDictionary
        
        UserDefaults.standard.setValue(Dic, forKey: "LANGUAGE_DATA")
    }
    
    // For Set Shadow To All Control
    func setShadow(obj:Any, cornurRadius:CGFloat, ClipToBound:Bool, masksToBounds:Bool, shadowColor:String, shadowOpacity:Float, shadowOffset:CGSize, shadowRadius:CGFloat, shouldRasterize:Bool, shadowPath:CGRect) {
        if obj is UIView {
            let tempView:UIView = obj as! UIView
            tempView.clipsToBounds = ClipToBound
            tempView.layer.cornerRadius = cornurRadius
            tempView.layer.shadowOffset = shadowOffset
            tempView.layer.shadowOpacity = shadowOpacity
            tempView.layer.shadowRadius = shadowRadius
            tempView.layer.shadowColor = self.getColorIntoHex(Hex: shadowColor).cgColor
            tempView.layer.masksToBounds =  masksToBounds
            tempView.layer.shouldRasterize = shouldRasterize
            tempView.layer.shadowPath = UIBezierPath(roundedRect: tempView.bounds, cornerRadius: cornurRadius).cgPath
        }
    }
    
    // For Set CornurRadius To All Control
    func setCornurRadius(obj:Any, cornurRadius:CGFloat, isClipToBound:Bool, borderColor:String, borderWidth:CGFloat) {
        if obj is UILabel {
            let tempLabel:UILabel = obj as! UILabel
            tempLabel.layer.cornerRadius = cornurRadius
            tempLabel.clipsToBounds = isClipToBound
            tempLabel.layer.borderColor = self.getColorIntoHex(Hex: borderColor).cgColor
            tempLabel.layer.borderWidth = borderWidth
        }
        if obj is UITextField {
            let tempTextField:UITextField = obj as! UITextField
            tempTextField.layer.cornerRadius = cornurRadius
            tempTextField.clipsToBounds = isClipToBound
            tempTextField.layer.borderColor = self.getColorIntoHex(Hex: borderColor).cgColor
            tempTextField.layer.borderWidth = borderWidth
        }
        if obj is UIButton {
            let tempButton:UIButton = obj as! UIButton
            tempButton.layer.cornerRadius = cornurRadius
            tempButton.clipsToBounds = isClipToBound
            tempButton.layer.borderColor = self.getColorIntoHex(Hex: borderColor).cgColor
            tempButton.layer.borderWidth = borderWidth
        }
        if obj is UITextView {
            let tempTextView:UITextView = obj as! UITextView
            tempTextView.layer.cornerRadius = cornurRadius
            tempTextView.clipsToBounds = isClipToBound
            tempTextView.layer.borderColor = self.getColorIntoHex(Hex: borderColor).cgColor
            tempTextView.layer.borderWidth = borderWidth
        }
        if obj is UIView {
            let tempView:UIView = obj as! UIView
            tempView.layer.cornerRadius = cornurRadius
            tempView.clipsToBounds = isClipToBound
            tempView.layer.borderColor = self.getColorIntoHex(Hex: borderColor).cgColor
            tempView.layer.borderWidth = borderWidth
        }
    }
    
    // For Set Same CornurRadius To All Control
    func setCornurRadiusToAllControls(allObj:[Any], cornurRadius:CGFloat, isClipToBound:Bool, borderColor:String, borderWidth:CGFloat) {
        for item in allObj {
            self.setCornurRadius(obj: item, cornurRadius: cornurRadius, isClipToBound: isClipToBound, borderColor: borderColor, borderWidth: borderWidth)
        }
    }
    
    // For Set PlaceHolderColor To TextField
    func setPlaceHolderColorToTextField(obj:UITextField,color:String) {
        obj.attributedPlaceholder = NSAttributedString(string:obj.placeholder!, attributes: [NSAttributedString.Key.foregroundColor:self.getColorIntoHex(Hex:color)])
    }
    // For Set PlaceHolderColorS To All TextFields
    func setPlaceHolderColorsToAllTextFields(allObj:[UITextField],color:String) {
        for item in allObj {
            self.setPlaceHolderColorToTextField(obj: item, color: color)
        }
    }
    
    // For Set Capital First Latter
    func setCapitalFirstLatter(word:String) -> String {
        if !word.isEmpty {
            let temp_Word:NSString = word as NSString
            let First_Char:NSString = (temp_Word.substring(to: 1) as NSString).uppercased as NSString
            let New_Upper_String:String = (First_Char as String) + ((temp_Word.substring(from: 1) as NSString) as String)
            return New_Upper_String
        }
        else {
            return ""
        }
    }
    
//    //MARK:- Login Model Get/Set
    func setLoginModel(modelResponse: BaseClassOfLogin)
    {
        Defaults[.Login_Response] = modelResponse.dictionaryRepresentation()
    }
    
    func getLoginModel() -> BaseClassOfLogin?
    {
        if let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: Defaults[.Login_Response])
        {
            return resultModel
        }
        return nil
    }
    
  // MARK:- Pretty Print Function
    
    func DictToJSON(with json: [String:Any]) -> String {
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return string! as String
    }
    
    func JSONToDict(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // MARK:- Convert Date To String
    
    func convertStringToDate(parsedate: String, currentDateFormate: String) -> Date {
        let format = DateFormatter()
        
        format.dateFormat = currentDateFormate
        
        let dt: Date = format.date(from: parsedate)!
        return dt
    }
    
    func convertDateToString(forApp date: String) -> Date {
        let format = DateFormatter()
        
        if date.count==10 {
            format.dateFormat = "dd MMM yyyy"
        }
        else
        {
            format.dateFormat = "yyyy-MM-dd hh:mm:ss"
        }
        
        let dt: Date = format.date(from: date)!
        return dt
    }
    
    func convertDateToMonthString(forApp strdate: String) -> String {
        
        let date = self.convertDateToString(forApp: strdate)
        let format = DateFormatter()
        format.dateFormat = "dd MMM yyyy"
        let dt: String = format.string(from: date)
        return dt
    }
    
    
    func convertDateFormater(parseDate: String, currentDateForate: String, newDateFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentDateForate
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = dateFormatter.date(from: parseDate) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = newDateFormate
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    func timeAgoSinceDate(date:Date, numericDates:Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now as Date
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        let month_ago = "month_ago"
        let months_ago = "months_ago"
        let day_ago = "day_ago"
        let yesterday = "yesterday"
        let week_ago = "week_ago"
        let days_ago = "days_ago"
        let last_week = "last_week"
        let weeks_ago = "weeks_ago"
        let last_month = "last_month"
        let last_year = "last_year"
        let years_ago = "years_ago"
        let year_ago = "year_ago"
        let hour_ago = "hour_ago"
        let hours_ago = "hours_ago"
        let just_now = "just_now"
        let minutes_ago = "minutes_ago"
        let minute_ago = "minute_ago"
        let seconds_ago = "seconds_ago"
        
        if (components.year! >= 2) {
            
            return "\(components.year!) "+"\(years_ago)"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 "+"\(year_ago)"
            } else {
                return "\(last_year)"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) "+"\(months_ago)"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 "+"\(month_ago)"
            } else {
                return "\(last_month)"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) "+"\(weeks_ago)"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 "+"\(week_ago)"
            } else {
                return "\(last_week)"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) "+"\(days_ago)"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 "+"\(day_ago)"
            } else {
                return "\(yesterday)"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) "+"\(hours_ago)"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 "+"\(hour_ago)"
            } else {
                return "An "+"\(hour_ago)"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) "+"\(minutes_ago)"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 "+"\(minute_ago)"
            } else {
                return "A "+"\(minute_ago)"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) "+"\(seconds_ago)"
        } else {
            return "\(just_now)"
        }
    }
}

class UtilityClass: NSObject {
    func getLoginModel() -> BaseClassOfLogin? {
            if let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: Defaults[.Login_Response]) {
                return resultModel
            }
            return nil
        }
    
    class func showhud() {
        let activityData = ActivityData()
        NVActivityIndicatorView.DEFAULT_TYPE = .ballTrianglePath
        NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 55
        NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 55
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    class func hidehud() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
   class func messageForErrorCode(errorCode: Int) -> String {
      var message: String = ""
      switch errorCode {
      case 400:
        message = NSLocalizedString("BadRequest", comment: "")
      case 401:
        message = NSLocalizedString("authentication_error", comment: "")
      case 403:
        message = NSLocalizedString("no_permission", comment: "")
      case 404:
        message = NSLocalizedString("data_not_found", comment: "")
      case 422:
        message = NSLocalizedString("data_not_in_correct_format", comment: "")
      case 500...599:
        message = NSLocalizedString("server_error", comment: "")
      case 600:
        message = NSLocalizedString("data_outdated", comment: "")
      case 1009:
        message = NSLocalizedString("internet_error", comment: "")
      default:
        message = NSLocalizedString("unknown_error", comment: "")
      }
      return message
    }
}




    func ws_login(){
        if ApiUtillity.sharedInstance.isReachable(){
            
            var parameters = [String : Any]()
            
            let data = Defaults[.Login_Response]
            let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: data)
            
            parameters = ["user_email": resultModel?.loginModel?.userEmail ?? "","user_signin_type": resultModel?.loginModel?.userType ?? "","user_password": resultModel?.loginModel?.userPassword ?? "","user_device":"iphone", "user_token":Defaults[.FCMToken]] as [String : Any]
            
            print(parameters)
            UtilityClass.showhud()
            
            APIClient.sharedInstance.API_POST(Url: WSLoginAPI, Params: parameters as [String : AnyObject], Authentication: true, mapObject: BaseClassOfLogin.self,SuperVC: self, completionSuccess:
                { response in
                    
                    let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: response.result.value)
                    print(response)
                    
                      ApiUtillity.sharedInstance.setLoginModel(modelResponse: resultModel!)
                  
                    UtilityClass.hidehud()
                    
                    print("---------------------")
                    print("Login Result:",resultModel?.toJSONString(prettyPrint: true))
                    print("---------------------")
                    
                    if let dataRes = response.response{
                        
                        if dataRes.statusCode == 200{
                            
                            if let headers = dataRes.allHeaderFields as? [String: String]{
                                
                                if let token = headers["Access-Token"], token.count != 0{
                                    print(token)
                                    Defaults[.headerToken] = token
                                }
                                
                                if let client = headers["Client"], client.count != 0{
                                    print(client)
                                    Defaults[.headerClient] = client
                                }
                                
                                if let uid = headers["Uid"], uid.count != 0{
                                    print(uid)
                                    Defaults[.headerUID] = uid
                                }
                            }
                            
                            Defaults[.isLogin] = true
//                            Defaults[.Login_Response] = (resultModel?.dictionaryRepresentation())!
//
//
                            ApiUtillity.sharedInstance.setLoginModel(modelResponse: resultModel!)

                            
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessVC") as! BusinessVC
                            
                            if let userEmail = resultModel?.loginModel?.userEmail, userEmail.count != 0{
                                vc.strGetUserEmail = userEmail}
                            
                            if let userType = resultModel?.loginModel?.userType, userType.count != 0{
                                vc.strType = userType}
                            
                            if let userPass = resultModel?.loginModel?.userPassword, userPass.count != 0{
                                vc.strGetUserPass = userPass}
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            Toast(text: resultModel?.message).show()
                            UtilityClass.hidehud()
                        }
                    }
            }) { (failed) in
                //                self.view_indicator.isHidden = true
                UtilityClass.hidehud()
                Toast(text: failed.localizedDescription).show()
            }
        }
        else
        {
            Toast(text: "No internet connection").show()
            UtilityClass.hidehud()
        }
    }
        
    func WS_SubScription() {
        
        APIClient.sharedInstance.API_GET(Url: WSSubscriptionCheck, Params: ["" : ""] as [String : AnyObject], Authentication: true, mapObject: BaseClassOfCategoryList.self,SuperVC: self, completionSuccess:
            { response in
                
                print(response)
                
                if let dataRes = response.response{
                    
                    if dataRes.statusCode == 200{
                        
                        let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: response.result.value)
                        print(resultModel?.message)
                    }else{
                        let resultErrorModel = Mapper<BaseClassOfLogin>().map(JSONObject: response.result.value)
                        Toast(text: resultErrorModel?.message).show()
                    }
                }
        }) { (failed) in
            Toast(text: failed.localizedDescription).show()
        }
    }
    
    
    func WS_EditCategoryList() {
        
        APIClient.sharedInstance.API_PUT(Url: WSEditCategoryAPI, Params: ["" : ""] as [String : AnyObject], Authentication: true, mapObject: BaseClassOfLogin.self,SuperVC: self, completionSuccess:
            { response in
                
                print(response)
                
                if let dataRes = response.response{
                    
                    if dataRes.statusCode == 200{
                        
                        let resultModel = Mapper<BaseClassOfLogin>().map(JSONObject: response.result.value)
                        Toast(text: resultModel?.message).show()
                    }
                    self.tableview_menu.reloadData()
                    
                }else{
                    let resultErrorModel = Mapper<BaseClassOfCategoryList>().map(JSONObject: response.result.value)
                    Toast(text: resultErrorModel?.message).show()
                }
        }) { (failed) in
            Toast(text: failed.localizedDescription).show()
        }
    }
}
  func uploadPicture(imageData:Data) {
        UtilityClass.showhud()
        APIClient().API_UPLOAD(Url: WSuploadImangeAPI, Params: ["" : "" as AnyObject], fileName: "profile.png", fileData: imageData, mimeType: "image/png", Authentication: true, mapObject: ModelFileUploadBase.self, SuperVC: self, completionSuccess: { (modelResponse) in
            
            let resultModel = Mapper<ModelFileUploadBase>().map(JSONObject: modelResponse)
            UtilityClass.hidehud()
            self.imgPics.image = UIImage.init(named: "")
            self.img_ogo.image = self.selectedImage
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                Toast(text: "Image Updated Successfully").show()
            })
            
            if(resultModel?.success == true), let userImg = resultModel?.imageName {
                UtilityClass.hidehud()
                self.uploadedImageName = userImg
                let img = WSProfileImageURL + self.uploadedImageName
                let url = URL(string: img)
                self.imgPics.isHidden = true
                self.img_ogo.kf.indicatorType = .activity
                self.img_ogo.kf.setImage(with: url, placeholder: UIImage(named: "imgdummy"), options: [.transition(.fade(0.2))])
            }
            else {
                UtilityClass.hidehud()
                if(resultModel?.success == true), let userImg = resultModel?.imageName, userImg.count != 0 {
                    self.uploadedImageName = userImg
                    let img = WSProfileImageURL + self.uploadedImageName
                    let url = URL(string: img)
                    
                    self.img_ogo.kf.indicatorType = .activity
                    self.img_ogo.kf.setImage(with: url, placeholder: UIImage(named: "imgdummy"), options: [.transition(.fade(0.2))])
                }
            }
        }) { (failed) in }
    }
