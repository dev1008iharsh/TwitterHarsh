//
//  CustomButtons.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 25/12/23.
//


import UIKit
class LableButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyleOfButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyleOfButton()
    }
    
    private func setStyleOfButton(){
        
        setTitleColor(.systemBackground, for: .normal)
        backgroundColor      = .label
        //titleLabel?.font     = UIFont(name: "GoogleSans-Bold", size: 20)
        layer.cornerRadius   = layer.frame.height/2
        
    }
    
    
}

class TwitterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyleOfButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setStyleOfButton()
    }
    
    
    private func setStyleOfButton(){
        
        setTitleColor(.white, for: .normal)
        backgroundColor      = .colourTwitterBlue
        //titleLabel?.font     = UIFont(name: "GoogleSans-Bold", size: 20)
        layer.cornerRadius   = layer.frame.height/2
        
    }
    
    
}
