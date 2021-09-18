//
//  LoginVC.swift
//  OpenWhen
//
//  Created by QUANG on 8/9/18.
//  Copyright © 2018 QUANG. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import SwiftyUserDefaults

class LoginVC: UIViewController, FBSDKLoginButtonDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.frame.size = CGSize(width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with Facebook")
        
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {
            return
        }
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signInAndRetrieveData(with: credentials) { (userData, err) in
            if let err = err {
                print("Something's wrong: ", err)
                return
            }
            print("Sucessfully log firebase through facebook: ", userData?.user.uid ?? "")
            currentUser = User(ID: "", name: "", email: "", avaURL: "")
            currentUser.ID = userData?.user.uid ?? ""
            currentUser.name = userData?.user.displayName ?? ""
            currentUser.email = userData?.user.email ?? ""
            
            if let accessToken = accessToken {
                currentUser.avaURL = "https://graph.facebook.com/\(accessToken.userID!)/picture?height=1000&width=1000"
                print(accessToken.userID!)
            }
            else {
                currentUser.avaURL = userData?.user.photoURL?.absoluteString ?? ""
            }

            Defaults[.userID] = currentUser!.ID
            Defaults[.username] = currentUser!.name
            Defaults[.userEmail] = currentUser!.email
            Defaults[.avatarURL] = currentUser!.avaURL
            
            ref = Database.database().reference()
            
            //createUserProfile
            ref.child("users").child(currentUser!.ID).child("id").setValue(currentUser!.ID)
            ref.child("users").child(currentUser!.ID).child("name").setValue(currentUser!.name)
            ref.child("users").child(currentUser!.ID).child("email").setValue(currentUser!.email)
            ref.child("users").child(currentUser!.ID).child("avaURL").setValue(currentUser!.avaURL)
            
            currentUser = User(ID: currentUser!.ID, name: currentUser!.name, email: currentUser!.email, avaURL: currentUser!.avaURL)
            
            self.moveToMainVC()
        }
    }
    
    func moveToMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: UITabBarController = storyboard.instantiateViewController(withIdentifier: "mainVC") as! UITabBarController
        present(controller, animated: true, completion: nil)
    }
}
