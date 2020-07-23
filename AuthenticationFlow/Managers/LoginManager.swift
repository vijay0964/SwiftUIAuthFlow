//
//  LoginManager.swift
//  AuthenticationFlow
//
//  Created by Augray on 21/07/20.
//  Copyright © 2020 vj. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices

class LoginManager: NSObject {
    typealias Completion = (Bool) -> Void
    
    private static let facebookPermissions = ["email"]
    private static let facebookGraphParameter = ["fields": "id, name, first_name, last_name, email"]
    
    //  MARK: Facebook Login
    
    static func loginFacebook(_ completion: Completion? = nil) {
        
        func getUserInfo() {
            GraphRequest(graphPath: "me", parameters: facebookGraphParameter).start { (connection, result, error) in
                guard error == nil else {
                    print("Facebook Graph request error: \(error!)")
                    completion?(false)
                    return
                }
                
                if let data = result as? [String: Any] {
                    print("Facebook User details from FB: \(data)")
                    completion?(true)
                }
            }
        }
        
        if LoginManager.isFacebookLoginAvailable() {
            getUserInfo()
        } else {
            let login = FBSDKLoginKit.LoginManager()
            login.logIn(permissions: LoginManager.facebookPermissions, from: nil) { (result, error) in
                guard error == nil else {
                    print("Facebook login error: \(error!)")
                    completion?(false)
                    return
                }
                
                guard result?.isCancelled == false else {
                    print("User Cancelled the process")
                    completion?(false)
                    return
                }
                
                guard result?.token != nil else {
                    print("Facebook login error")
                    completion?(false)
                    return
                }
                
                getUserInfo()
            }
        }
    }
    
    static func isFacebookLoginAvailable() -> Bool {
        let token = AccessToken.current
        return token != nil && token?.isExpired == false
    }

    static func isGoogleLoginAvailable() -> Bool {
        return GIDSignIn.sharedInstance()?.hasPreviousSignIn() == true
    }
    
    static func isAppleLoginAvailable(_ completion: @escaping Completion) {
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: "") { (state, error) in
            guard error == nil else {
                completion(false)
                return
            }
            
            completion(state == .authorized)
        }
    }
}

extension LoginManager {
    static func logout() {
        // FB Logout
        let login = FBSDKLoginKit.LoginManager()
        login.logOut()
        FBSDKLoginKit.AccessToken.current = nil
        
        // Google Logout
        GIDSignIn.sharedInstance()?.signOut()
        
        // Apple Logout
        
    }
}
