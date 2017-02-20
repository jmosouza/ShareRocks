//
//  ViewController.swift
//  ShareRocks
//
//  Created by João Marcelo on 20/02/17.
//  Copyright © 2017 João Marcelo Oliveira de Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bundleToBrand = [
        "com.apple.UIKit.activity.PostToFacebook": "facebook",
        "ph.telegra.Telegraph.Share": "telegram",
        "com.apple.UIKit.activity.PostToTwitter": "twitter"
    ]

    @IBAction func didTapShareButton(_ sender: Any) {
        presentShareDialog()
    }
    
    func presentShareDialog() {
        let sample = "hello world"
        let dialog = UIActivityViewController(
            activityItems: [sample],
            applicationActivities: nil)
        dialog.completionWithItemsHandler = dialogHandler
        present(dialog, animated: true, completion: nil)
    }
    
    func dialogHandler(
        _ activityType: UIActivityType?,
        _ completed: Bool,
        _ returnedItems: [Any]?,
        _ activityError: Error?) {
        
        // Check completed.
        guard completed else {
            print("Not completed")
            return
        }
        
        // Get the bundle of the app that handled the activity.
        // e.g. "ph.telegra.Telegraph.Share" for Telegram.
        guard let bundle = activityType?.rawValue else {
            print("Unable to identify type")
            return
        }
        
        // Add brand if not listed.
        if nil == bundleToBrand[bundle] {
            bundleToBrand[bundle] = bundle
        }
        
        // Get brand.
        guard let brand = bundleToBrand[bundle] else {
            print("Unexpected brand")
            return
        }
        
        print("Complete")
        print(brand)
        print(bundle)
    }

}

