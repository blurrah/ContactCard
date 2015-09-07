//
//  LoadingOverlayController.swift
//  ContactCard
//
//  Created by Boris Besemer on 07-09-15.
//  Copyright (c) 2015 Boris Besemer. All rights reserved.
//  Based on https://gist.github.com/igordeoliveirasa/78a310f0348fcad9b270

import Foundation
import UIKit

public class LoadingOverlayController {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var sharedInstance: LoadingOverlayController {
        struct Singleton {
            static let instance: LoadingOverlayController = LoadingOverlayController()
        }
        
        return Singleton.instance
    }
    
    public func showOverlayView(view: UIView!) {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}