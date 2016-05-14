//
//  ViewController.swift
//  Twitter Integration
//
//  Created by Aaqib Hussain on 14/05/2016.
//  Copyright © 2016 Aaqib Hussain. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    @IBOutlet weak var customLogin: UIButton!
    @IBOutlet weak var logout: UIButton!
    var logInButton : TWTRLogInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let client = TWTRAPIClient()
                client.loadUserWithID((unwrappedSession.userID), completion: { (user, error) -> Void in
                    print("UserName: \(unwrappedSession.userName)")
                    print("Name: \(user!.name)")
                    print("Image Url: \(user!.profileImageURL)")
                })

                self.logInButton.hidden = true
                self.logout.hidden = false
                self.customLogin.hidden = true

            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    @IBAction func logoutFromTwitter(sender: UIButton) {
    
        let store = Twitter.sharedInstance().sessionStore
        
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
            print("Logged Out!")
            self.logInButton.hidden = false
            self.logout.hidden = true
            self.customLogin.hidden = false
            
        }

    
    
    }

    @IBAction func logInWithCustomButton(sender: UIButton) {
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            if (session != nil) {
                print("signed in as \(session!.userName)")
                self.logout.hidden = false
                self.logInButton.hidden = true
                  self.customLogin.hidden = true
                let client = TWTRAPIClient()
                client.loadUserWithID((session?.userID)!, completion: { (user, error) -> Void in
                    print("Name: \(user!.name)")
                    print("Image Url: \(user!.profileImageURL)")
                })
                        
                    }
                    
            

        
    }
}
}
