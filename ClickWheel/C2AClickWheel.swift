//
//  C2AClickWheel.swift
//  ClickWheel
//
//  Created by Dirk Gerretz on 16/03/15.
//  Copyright (c) 2015 [code2app];. All rights reserved.
//

import UIKit
import AudioToolbox

// !!!! DO NOT USE SIZE CLASSES IN INTERFACE BUILDER !!!!

@IBDesignable class C2AClickWheel: UIButton {

    // MARK: Properties
    let π = CGFloat(M_PI)

    //@IBInspectable changes should be applied in the Attributes Inspector in Interface Builer

    // Wheel Colors
    @IBInspectable var wheelColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var buttonColor: UIColor = UIColor.darkGrayColor()
//    @IBInspectable var centerTitle: String = "OK"

    // Switch feedback sound on/off. False is the default for debugging only
    #if DEBUG
    @IBInspectable var feedbackSound: Bool = false
    #else
    @IBInspectable var feedbackSound: Bool = true
    #endif

    // Define the thickness of the arc.
    @IBInspectable var arcWidth: CGFloat = 50

    // will be set at dragging and reflecting the angle in the clickWheel
    // an angle of 0° being at the 9 o'clock position of the wheel like in
    // a unitcircle. Also, in a unitcirlce the angle increases going counte-
    // clockwise. Therefore a decreaseing angle will increase the counter
    // so dragging feel right to the user.
    var angle: Int = 0 {
        didSet {

            // alter modulo for more or less momentum/precision
            if angle % 5 == 0 {

                if oldValue > angle {
                    counter++
                } else {
                    counter--
                }
                if feedbackSound {
                    playClickSound()
                }
            }
        }
    }

    // the value that will be eventually used
    var counter: Int = 0

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        // add circular button to the center of the clickwheel

        // instantiate a centerButton
        let centerButton = UIButton()

        // calculate the size of the center button and display the button accordingly
        centerButton.frame = calculateButtonPosition(self.frame)

        // set centerButton properties
        centerButton.backgroundColor = buttonColor

        // Button title
        centerButton.setTitle(self.titleLabel?.text, forState: .Normal)
        centerButton.titleLabel!.font =  self.titleLabel?.font
        centerButton.setTitleColor(self.titleColorForState(.Normal), forState: UIControlState.Normal)

        superview?.addSubview(centerButton)

    }


    /*
    override func layoutSubviews() {


        println("layout Sub")

        // add circular button to the center of the clickwheel

        // instantiate a centerButton
        let centerButton = C2ACircularButton()

        // let centerButton have access to properties of clickWheel
        centerButton.hostView = self

        // calculate the size of the center button and display the button accordingly
        centerButton.calculateButtonPosition(self.frame)

        // set centerButton properties
        centerButton.backgroundColor = .yellowColor()
        centerButton.fillColor = buttonColor

        // Button title
        centerButton.setTitle(self.titleLabel?.text, forState: .Normal)
        centerButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Light", size: centerButton.frame.width * 0.3)
        centerButton.tintColor = .whiteColor()

        superview?.addSubview(centerButton)

    }
*/
    override func drawRect(rect: CGRect) {

        //Define the center point of the view where you’ll rotate the arc around.
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)

        // Draw the outer arc

        // Calculate the radius based on the max dimension of the view.
        // max returns the greater of any x and y.
        var radius: CGFloat = (max(bounds.width, bounds.height)/2)

        // Define the start and end angles for the arc as radians.
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π

        // Create a path based on the center point, radius, and angles you just defined.
        var path = UIBezierPath(arcCenter: center,
            radius: radius - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        // Set the line width and color before finally stroking the path.
        path.lineWidth = arcWidth
        wheelColor.setStroke()
        path.stroke()

        // draw innner circle

        // calculate radius for inner circle
        radius = radius - arcWidth

        // Create a path based on the center point, radius, and angles you just defined.
        path = UIBezierPath(arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)

        // set color for inner circle and fill path
        buttonColor.setFill()
        path.fill()
    }

    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        let lastPoint = touch.locationInView(self)

        let centerPoint:CGPoint  = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

        //Calculate the direction from a center point and a arbitrary position.
        let currentAngle:Double = AngleFromNorth(centerPoint, p2: lastPoint, flipped: false);
        let angleInt = Int(floor(currentAngle))

        //Store the new angle
        angle = Int(360 - angleInt)

        //Console out new value locally 
 //       println("Dragging: \(angle)°")

        // send noctifications other other coan register for
        sendActionsForControlEvents(.ValueChanged)

        return true
    }

    // Apple Sourcecode Example
    // Calculate the direction in degrees from a center point to an arbitrary position.
    func AngleFromNorth(p1:CGPoint , p2:CGPoint , flipped:Bool) -> Double {
        var v:CGPoint  = CGPointMake(p2.x - p1.x, p2.y - p1.y)
        let vmag:CGFloat = Square(Square(v.x) + Square(v.y))
        var result:Double = 0.0
        v.x /= vmag;
        v.y /= vmag;
        let radians = Double(atan2(v.y,v.x))
        result = RadiansToDegrees(radians)
        return (result >= 0  ? result : result + 360.0);
    }

    // MARK: Converters
    func DegreesToRadians (value:Double) -> Double {
        return value * M_PI / 180.0
    }

    func RadiansToDegrees (value:Double) -> Double {
        return value * 180.0 / M_PI
    }

    func Square (value:CGFloat) -> CGFloat {
        return value * value
    }

    func playClickSound(){
/*
        let filePath = NSBundle.mainBundle().pathForResource("Tock", ofType: "caf")
        let fileURL = NSURL(fileURLWithPath: filePath!)
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fileURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
*/
    }

    func calculateButtonPosition(hostRect: CGRect) ->CGRect{

        println("Device: \(hostRect)")
        println("Wheel Button: \(self.frame)")

        let buttonWidth = calculateCenterButtonSize(self.frame.width, arcWidth: self.arcWidth)

        let positionX = hostRect.origin.x + ((hostRect.width / 2) - (buttonWidth / 2))
        let positionY = hostRect.origin.y + ((hostRect.width / 2) - (buttonWidth / 2))

        let newFrame = CGRectMake(positionX, positionY, buttonWidth, buttonWidth)

        println("Center Button \(newFrame)")

        return newFrame
    }

    func calculateCenterButtonSize(width: CGFloat, arcWidth: CGFloat) -> CGFloat {
        // at this point it is already clear that both width and heights are equal
        // This was checked when the host view was pulled out in Interface Builder

        // this calcualtes the max diagonal for the square inside the ClickWheel
        let diagonal = (width - (arcWidth * 2)) * 1.0

        // calculate square side length using Pythagoras' law
        return sqrt((pow(diagonal, 2.0) / 2))
    }

}

