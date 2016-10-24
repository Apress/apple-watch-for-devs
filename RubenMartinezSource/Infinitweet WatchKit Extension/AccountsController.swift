//
//  AccountsController.swift
//  Infinitweet
//
//  Created by Ruben on 5/27/15.
//
//

import WatchKit
import Foundation
import Accounts

class AccountsController: WKInterfaceController {
    @IBOutlet weak var accountsTable: WKInterfaceTable!
    var accounts : [ACAccount]?
    var delegate : AccountSelectionDelegate?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if context != nil {
            self.accounts = context!.objectForKey("accounts") as? [ACAccount]
            self.delegate = (context!.objectForKey("delegate") as! PreviewController)
            
            if self.accounts != nil {
                // Set number of rows to number of Accounts
                self.accountsTable.setNumberOfRows(self.accounts!.count, withRowType: "AccountRow")
                
                //Populate rows with Account usernames
                for var i = 0; i < self.accountsTable.numberOfRows; i++ {
                    var row = self.accountsTable.rowControllerAtIndex(i) as! AccountRow
                    row.name.setText("@\(self.accounts![i].username)")
                }
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        delegate?.postImageToAccount(self.accounts![rowIndex])
        self.dismissController()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
protocol AccountSelectionDelegate {
    func postImageToAccount(account : ACAccount)
}