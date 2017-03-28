//
//  PreviewController.swift
//  Infinitweet
//
//  Created by Ruben on 5/17/15.
//
//

import WatchKit
import Foundation
import Accounts
import Social


class PreviewController: WKInterfaceController, AccountSelectionDelegate, AlertControllerDelegate {
    @IBOutlet var imageDisplay : WKInterfaceImage!
    var imageToShare : UIImage?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if context != nil && context!.objectForKey("image") != nil {
            self.imageToShare = (context!.objectForKey("image") as? UIImage)
            self.imageDisplay.setImage(self.imageToShare)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func share() {
        // Load Synced Account Database
        let accountStore = ACAccountStore()
        
        // Specify Type of Account we want to use
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        // Check if we already have permission
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("permissionsGranted") {
            chooseAccount(accountType, fromStore: accountStore)
        } else {
            // Ask User to Check Device
            self.presentControllerWithName("AlertController", context: ["delegate" : self, "text" : "See iOS Device", "positive" : false, "destructive" : true])
            
            // Prompt user for permission to use their Twitter account
            accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
                granted, error in
                
                if granted {
                    var defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setBool(true, forKey: "permissionsGranted")
                    defaults.synchronize()
                    
                    self.chooseAccount(accountType, fromStore: accountStore)
                }
                else {
                    self.presentControllerWithName("AlertController", context: ["delegate" : self, "text" : "Access Denied", "positive" : false, "destructive" : true])
                }
            }
        }
    }
    
    // Choose account to post from
    func chooseAccount(type : ACAccountType, fromStore store : ACAccountStore) {
        let twitterAccounts = store.accountsWithAccountType(type)
        
        if twitterAccounts.count == 0 {
            self.presentControllerWithName("AlertController", context: ["delegate" : self, "text" : "No Twitter Accounts", "positive" : false, "destructive" : true])
        }
        else if twitterAccounts.count > 1 {
            self.presentControllerWithName("AccountsController", context: ["accounts": twitterAccounts, "delegate" : self])
            
        } else {
            self.postImageToAccount(twitterAccounts.first as! ACAccount)
        }
    }
    
    func postImageToAccount(account : ACAccount) {
        if let image = self.imageToShare {
            // URL for posting an image, according to Twitter API
            let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/update_with_media.json")
            
            // Prepare image posting request
            var postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: requestURL, parameters: nil)
            postRequest.addMultipartData(UIImageJPEGRepresentation(image, 1.0), withName: "media[]", type: "multipart/form-data", filename: nil)
            postRequest.addMultipartData("".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), withName: "status", type: "multipart/form-data", filename: nil)
            postRequest.account = account
            
            postRequest.performRequestWithHandler({ (responseData, urlResponse, error) -> Void in
                if error == nil {
                    self.presentControllerWithName("AlertController", context: ["delegate" : self, "text" : "Success!", "positive" : true, "destructive" : true])
                } else {
                    self.presentControllerWithName("AlertController", context: ["delegate" : self, "text" : "Error", "positive" : false, "destructive" : true])
                }
            })
        }
    }

    func alertControllerDidCompleteDestructively(destructive : Bool) {
        if destructive {
            self.popToRootController()
        }
    }
}
