//
//  C2AButton.swift
//  ClickWheel
//
//  Created by Dirk Gerretz on 20/03/15.
//  Copyright (c) 2015 [code2app];. All rights reserved.
//

import UIKit

class C2ACircularButton: UIButton {
    //MARK: Properties

    // inherited from hostView.
    var fillColor: UIColor =  UIColor.blueColor()

    // assure access to parents properties
    // set weak to avoid retain cyvle
    weak var hostView: C2AClickWheel?

//    override var frame: CGRect {
//        didSet {
//            println("didSet: \(frame)")
//            setNeedsDisplay()
//        }
//    }

    //MARK: Create Center Button
    func calculateButtonPosition(hostRect: CGRect) {

        if let host = hostView {

            let buttonWidth = calculateCenterButtonSize(host.frame.width, arcWidth: host.arcWidth)

            let positionX = hostRect.origin.x + ((hostRect.width / 2) - (buttonWidth / 2))
            let positionY = hostRect.origin.y + ((hostRect.height / 2) - (buttonWidth / 2))

            self.frame = CGRectMake(positionX, positionY, buttonWidth, buttonWidth)
        }
    }

    func calculateCenterButtonSize(width: CGFloat, arcWidth: CGFloat) -> CGFloat {
        // at this point it is already clear that both width and heights are equal
        // This was checked when the host view was pulled out in Interface Builder

        // this calcualtes the max diagonal for the square inside the ClickWheel
        let diagonal = (width - (arcWidth * 2)) * 1.0

        // calculate square side length using Pythagoras' law
        return sqrt((pow(diagonal, 2.0) / 2))
    }


    override func drawRect(rect: CGRect) {

        var path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()

        //create the path
        var plusPath = UIBezierPath()

        //set the stroke color
        UIColor.whiteColor().setStroke()

        //draw the stroke
        plusPath.stroke()
    }

}
