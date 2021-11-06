//
//  APIManager.swift
//  FoodDeliveryApp
//
//  Created by Alvaro Gonzalez on 11/4/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class APIManager {
    static let shared = APIManager()
    
    let baseURL = NSURL(string: BASE_URL)
    
    var accessToken = ""
    var refreshToken = ""
    var expired = Date()
    
    
    
    //APi to login the user
    func login(userType: String, completitionHandler: @escaping (NSError?) -> Void) {
     
        
        let path = "api/social/convert-token/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "grant_type": "convert_token",
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "backend" : "facebook",
            //"token" : "EABAlDuctbpMBAMZAXxa9WIgsEB3k6s54r3bbHvpE4CuU8FM4WAZAZAHLFoaZC2yOeKsZCXhZCStyeGQSfxFCvVAzIZCLVzOp72Je2jb4ow3sZBCArh3fAgYsVu69Jf6xWsyffQQoQImpcLIXzTSyZAd2fI7KVdcY00XvWqgBZAEQgSb9rGahq1GrpLgmxYvdRMztl6XSQDPJJKlyawzcq6DHk4dsyknhntGNw0VGwnZBHRbpgoGLE2ithJWMd2wjzxTz7YZD",
            "token" : AccessToken.current!.tokenString,
            //"token" : AccessToken.current!,
            "user_type" : userType,
        ]
        print("__________________________________________")
//        print(url)
//        print(params)
        
        //Using alamofire for the request
        AF.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON {
            (response) in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                

                print("__________________________________________")
                print(jsonData)
                
                self.accessToken = jsonData["access_token"].string!
                self.refreshToken = jsonData["refresh_token"].string!
                self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expires_in"].int!))

                completitionHandler(nil)
                print("_______________Success___________________")
                break


            case .failure(let error):
                completitionHandler(error as NSError)
                print("________EROR______")
                break

            }
        }
        
        
    }
    
    
    
    
    //Aoi to logout the user
    func logout(completionHandler: @escaping (NSError?) -> Void) {
        
        let path = "api/social/revoke-token/"
        let url = baseURL!.appendingPathComponent(path)
        let params: [String: Any] = [
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "token" : self.accessToken,
            
        ]
        
        // Alamofire for the requests
        AF.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON{(response) in
            
            switch response.result {
            case .success:
                completionHandler(nil)
                break
            
            case .failure(let error):
                completionHandler(error as NSError?)
            }
        }
    }
    
    
    
    
    
    
    // API to refresh the token when it's expired
    func refreshTokenIfNeed(completionHandler: @escaping () -> Void) {
        
        let path = "api/social/refresh-token/"
        let url = baseURL?.appendingPathComponent(path)
        let params: [String: Any] = [
            "access_token": self.accessToken,
            "refresh_token": self.refreshToken
        ]
        
        if (Date() > self.expired) {
            
            AF.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: { (response) in
                
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    self.accessToken = jsonData["access_token"].string!
                    self.expired = Date().addingTimeInterval(TimeInterval(jsonData["expires_in"].int!))
                    completionHandler()
                    break
                    
                case .failure:
                    break
                }
            })
        } else {
            completionHandler()
        }
    }
    
    
    
    
    
   
    
    
//    Get restaurants List
    
    func getRestaurants(completionHandler: @escaping (JSON?) -> Void){
        let path = "api/customer/restaurants/"
        let url = baseURL?.appendingPathComponent(path)
        
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
            
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                completionHandler(jsonData)
                break
                
            case .failure:
                completionHandler(nil)
                break
            }
        }
        
        
        
    }
    
    //    Get restaurants List
        
    func getMeals(resturantId: Int, completionHandler: @escaping (JSON?) -> Void){
        let path = "api/customer/meals/\(resturantId)"
        let url = baseURL?.appendingPathComponent(path)
            
        AF.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{ response in
                
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                    break
                    
                case .failure:
                    completionHandler(nil)
                    break
                }
            }
            
            
            
        }
    
    
    
    
    
    
    
    
    
    
    
    
//End Class APIMAnager
}
