//
//  Extensions.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 25/12/23.
//

import Foundation
import UIKit

extension UIViewController {

    func addLogoToNavigationBarItem(imageName : String, sizeOfImage : CGFloat) {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: sizeOfImage).isActive = true
      
    
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
 
 
 

extension UIApplication {
     isible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
extension String {
    var isValidateSecialPassword : Bool {
        
        if(self.count>=8 && self.count<=20){
        }else{
            return false
        }
  (format:"SELF MATCHES %@", smallLetterRegEx)
        let smallresult = samlltest.evaluate(with: self)
        
        let numberRegEx  = ".*[0-9]+.*"
        let numbertest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = numbertest.evaluate(with: self)
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
        var isSpecial :Bool = false
        if regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, self.count)) != nil {
            print("could not handle special characters")
            isSpecial = true
        }else{
            isSpecial = false
      
        return (strUpper.count >= 1) && smallresult && numberresult && isSpecial
    }
    
    func containsWhitespaceAndNewlines() -> Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }
    
}
 
