//
//  Infinitweet.swift
//  Infinitweet
//
//  Created by Ruben on 5/27/15.
//
//

import Foundation
import UIKit

class Infinitweet {
    // Will store Infinitweet image after initialization
    var image : UIImage
    
    // Default Infinitweet Properties
    let defaultFont       = UIFont.systemFontOfSize(16)
    let defaultColor      = UIColor.blackColor()
    let defaultBackground = UIColor.whiteColor()
    let defaultPadding    = 20.0 as CGFloat
    
    init(text : String) {
        let ratio = 2  as CGFloat // Twitter images in stream appear in 2:1 aspect ratio
        let delta = 10 as CGFloat // Amount to change image width by per cycle
        let maxCycles = 1000      // After this many cycles, give up
        
        // Set text properties
        let options = unsafeBitCast(NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        let textAttributes = [NSFontAttributeName: defaultFont, NSForegroundColorAttributeName: defaultColor]
        
        // Set initial image attempt properties
        var currentWidth = 200 as CGFloat
        var imageSize = (text as NSString).boundingRectWithSize(CGSizeMake(currentWidth, CGFloat.max), options: options, attributes: textAttributes, context: nil)
        
        var currentHeight = imageSize.height
        var lastRatio = currentWidth/currentHeight
        var lastDelta = InfinitweetDelta.Positive
        
        var cycleCount = 0
        while cycleCount++ < maxCycles {
            if lastRatio >= ratio {
                currentWidth -= delta
                lastDelta = InfinitweetDelta.Negative
            } else {
                currentWidth += delta
                lastDelta = InfinitweetDelta.Positive
            }
            
            // Recalculate size based off new width
            imageSize = (text as NSString).boundingRectWithSize(CGSizeMake(currentWidth, CGFloat.max), options: options, attributes: textAttributes, context: nil)
            
            // Recalculate width:height ratio
            currentHeight = imageSize.height
            let currentRatio = currentWidth/currentHeight
            

            // If last change didn't improve, revert and give up
            if abs(ratio-lastRatio) < abs(ratio-currentRatio) {
                currentWidth = (lastDelta == InfinitweetDelta.Positive) ? currentWidth - delta : currentWidth + delta
                imageSize = (text as NSString).boundingRectWithSize(CGSizeMake(currentWidth, CGFloat.max), options: options, attributes: textAttributes, context: nil)
                currentHeight = imageSize.height
                break
            }
            
            // If we're already near our target, give up
            if abs(ratio-currentRatio) < 0.05 {
                break
            } else { // Else keep going
                lastRatio = currentRatio
            }
        }
        
        // Round sizes for Infinitweet
        let minSize = (width : CGFloat(440), height : CGFloat(220))
        let adjustedWidth  = max(CGFloat(ceilf(Float(currentWidth))), minSize.width)
        let adjustedHeight = max(CGFloat(ceilf(Float(currentHeight))), minSize.height)
        
        // Outer rect is overall image size, Inner rect contains text
        let outerRect = CGRectMake(0, 0, adjustedWidth + 2*defaultPadding, adjustedHeight + 2*defaultPadding)
        let innerRect = CGRectMake(defaultPadding, defaultPadding, adjustedWidth, adjustedHeight)
        
        // Generate image
        UIGraphicsBeginImageContextWithOptions(outerRect.size, true, 0.0)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        
        image.drawInRect(CGRectMake(0,0,outerRect.size.width,outerRect.size.height))
        
        // Set Background Color
        defaultBackground.set()
        
        // Fill background
        CGContextFillRect(UIGraphicsGetCurrentContext(), outerRect)
        
        // Draw text
        text.drawInRect(CGRectIntegral(innerRect), withAttributes: textAttributes)
        
        // Save new image
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    enum InfinitweetDelta {
        case Positive, Negative
    }
}