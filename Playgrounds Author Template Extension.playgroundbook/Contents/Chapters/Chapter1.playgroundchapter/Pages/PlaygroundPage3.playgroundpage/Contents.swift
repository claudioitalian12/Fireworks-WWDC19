//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Instantiates a live view and passes it to the PlaygroundSupport framework.
//
import UIKit
import PlaygroundSupport
//#-end-hidden-code
/*:
 ## But ... where are the fireworks?
 I tried for a whole week to change the **circular shape** of the explosions, tried to get passionate about the subject, but by trying to the end I didn't succeed and I fell into insecurity.
 
 I reflected on my entire work and asked myself:
 
 why continue? **better to stop writing, better to stop programming.**
 
 ## But in the end I asked myself:
creating something I like from a failure is what will give me the strength to continue. Being able to **communicate everything** I have tried will make me remember not to fall into doubt anymore.
 
 ## End:
One thing I learned during this period is that fireworks are used symbolically to ward off the negativity of the old year and improve the next one.
 
 So I hope these fireworks can help someone get through a bad time.
 */
let colorFireworks = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
//#-hidden-code
do{
    sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: colorFireworks, requiringSecureCoding: true)))
}
catch let error { fatalError("error") }
//#-end-hidden-code
