//
//  ViewController.swift
//  What's The Weather
//
//  Created by Divine Davis on 8/31/15.
//  Copyright (c) 2015 Divine's Ideas. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    //They user types in the city they want to recieve the weather from
    @IBOutlet weak var city: UITextField!
    
    //The label that is being updated when the data finally reaches the phone
    @IBOutlet weak var message: UILabel!
    
    //The progress bar
    @IBOutlet weak var downloadProgress: UIProgressView!
    
    //My 'What's the weather?' button
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //When you touch the button, the keyboard goes away
        self.view.endEditing(true)
        
        //setting the urlString to the address of the website, it will add the city that you type into the city text field
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        //Setting the url to the urlString
        var url = NSURL(string: urlString)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            if (urlContent!.containsString("<span class=\"phrase\">")){
                
                var contentArray  = urlContent!.componentsSeparatedByString("<span class=\"phrase\">")
                var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
                
                //Make this the main part of the code I want to run first
                dispatch_async(dispatch_get_main_queue()) {
            
                //Changing the text color to white
                self.message.textColor = UIColor .whiteColor()
                self.message.text = (newContentArray[0] as! String)
                    
                }
            } else {
                
                //Stop doing anything else and complete this code also
                dispatch_async(dispatch_get_main_queue()) {

                
                //Changing the text color to red
                self.message.textColor = UIColor .redColor()
                
                //Error message
                self.message.text = "The weather was not able to be retrieved"
                }
            }
        }
        task.resume()
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        self.downloadProgress.progress = 0.0
    }
//    }
//    func makeMyProgressBarMoving {
//    
//        var recievedData : Float
//        var expectedTotalSize : Float
//        var actual : Float = downloadProgress.progress
//        if (actual < 1) {
//            downloadProgress.progress = actual + (recievedData/expectedTotalSize)
//            [NSTimer .scheduledTimerWithTimeInterval(0.05, invocation: self, repeats: false)]
//        }
//        
//    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}