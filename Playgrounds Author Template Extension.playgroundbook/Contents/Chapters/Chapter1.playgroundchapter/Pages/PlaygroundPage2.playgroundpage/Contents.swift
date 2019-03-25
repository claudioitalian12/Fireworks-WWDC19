/*:
 ## What can we do to tackle the problem?
 I can't do anything, I can't sew, I can't dance, I can't sing, I can't play musical instruments, I can't write well. These phrases are often said by those who suffer from this problem.
 
 The first step to change oneself is to try to rediscover the **qualities** and **skills** that have always distinguished us.
 
 ## Failing in something does not mean giving up:
 Often we have to deal with failures, but this does not mean we cannot do anything and it does not mean having to renounce our passions.
 
  **1.** **Walt Disney** was fired because he was considered unimaginative and without good ideas.
 
  **2.** **J.K. Rowling**, before writing Harry Potter, was unemployed, divorced and with a dependent daughter.
 
  **3.** **R. H. Macy** has failed several times before becoming a successful entrepreneur.
 
  All this to say that failure must not make us stop being passionate about something, because only by stopping can we fail.
 
 ## Capture your skills:
Now write what you think can be your strengths, your passions:

 */
//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


//Messaging from Page to Live View:
import Foundation
import UIKit
import PlaygroundSupport
//Use the call below to send a message with an object to the LiveView of this page. Import Foundation is required.
//sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: /*YourObject*/, requiringSecureCoding: true)))



//Give hints and final solution:
//PlaygroundPage.current.assessmentStatus = .fail(
//hints: [
//"You could [...].",
//"Try also [...]."
//],
//solution:
//"Do [...]."
//)



// Completion of user-entered code:
//Use //#-code-completion syntax to allow only specified code to be entered by the user. (info here: https://developer.apple.com/documentation/swift_playgrounds/customizing_the_completions_in_the_shortcut_bar)



PlaygroundPage.current.assessmentStatus = PlaygroundPage.AssessmentStatus.fail(hints: ["Words are generated within a radius of a few meters from your location.","If you don't see the words, check again where you went with the camera."], solution: nil)

//#-end-hidden-code
let skills = [/*#-editable-code*/"sociable"/*#-end-editable-code*/,/*#-editable-code*/"educated"/*#-end-editable-code*/,/*#-editable-code*/"careful"/*#-end-editable-code*/]

let colorSkills = [/*#-editable-code*/#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)/*#-end-editable-code*/,/*#-editable-code*/#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)/*#-end-editable-code*/,/*#-editable-code*/#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)/*#-end-editable-code*/]
//#-hidden-code
do{
    sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: skills, requiringSecureCoding: true)))
}
catch let error { fatalError("error") }
do{
    sendValue(.data(try NSKeyedArchiver.archivedData(withRootObject: colorSkills, requiringSecureCoding: true)))
}
catch let error { fatalError("error") }
//#-end-hidden-code
/*:
 
When you're done, execute the code and cross the words to capture them!
 
 
[**Next Page**](@next)
*/
