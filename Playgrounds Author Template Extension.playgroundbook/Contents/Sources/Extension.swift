//
//  Extension.swift
//  Book_Sources
//
//  Created by claudio Cavalli on 24/03/2019.
//
//
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit

extension UIView {
    func transitionAnimation(_ durationTime:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = durationTime
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
extension CGRect{
    var center: CGPoint {
        return CGPoint( x: self.size.width * 0.5,y: self.size.height * 0.5)
    }
}
func randomPositionV3 (lowerB:Float, upperB :Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lowerB - upperB) + upperB
}
func randomNumberV3 (lowerB:Int, upperB:Int) -> Int {
    return Int(arc4random()) / Int(UInt32.max) * (lowerB - upperB) + upperB
}
