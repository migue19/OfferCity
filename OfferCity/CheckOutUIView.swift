//
//  CheckOutUIView.swift
//  OfferCity
//
//  Created by Miguel Mexicano Herrera on 21/05/17.
//  Copyright © 2017 Miguel Mexicano Herrera. All rights reserved.
//

import UIKit

class CheckOutUIView: UIView {

    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.width/16
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3.0
        
        //let color = UIColor.red
        let startPoint = CGPoint(x: 0, y: self.layer.bounds.height-65)
        let endPoint = CGPoint(x: self.layer.bounds.width, y: self.layer.bounds.height-65)
        
        addLine(fromPoint: startPoint, toPoint: endPoint)
        
        
    }
    
    

    
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.init(red: 99/255.0, green: 126/255.0, blue: 165/255.0, alpha: 1).cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.layer.addSublayer(line)
    }
    
   /* override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:/*Put starting Location*/50, y:/*Put starting Location*/50))
        
        aPath.addLine(to: CGPoint(x:/*Put Next Location*/200, y:/*Put Next Location*/50))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
        
        self.layer.cornerRadius = self.layer.frame.width/16
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3.0
    }*/
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
