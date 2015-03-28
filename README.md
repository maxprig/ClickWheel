# ClickWheel
### Drop-In ClickWheel for iOS 7.0+ written in Swift

ClickWheel basically consits of two buttons on top of each other. One is responsible for the dragging while the inner one only responds to clicks. ClickWheel is built as @IBDesignable class with @IBInspectable attributes. This means that you'll see in Interface Builder right away when you alter a color or the width of the outer wheel. The innner button is created programmatically at run time. However, you can alter the button title also in Interface Builder.

Like a real click wheel the outer wheel only responds to dragging while the inner button only responds to clicks (touch up inside). Upon dragging ClickWheel will provide the angle relative to its center point. 0/360 degree in the demo project is at the 3 o'Clock position as in an unitcircle. In the demo project the angle is displayed in an UILabel along with an indication if dragging is done forward or backward.

### How to use ClickWheel in your porject? Very easily!

- In Interface Builder pull out an UIButton to you ViewController and give it proper size and positioning. 
- In the Identity Inspector make it of class C2AClickWheel
- ClickWheel works nicely with Auto Layout and Auto Size Classes
- Set the inner and outer color, the width of the outer wheel and the button title in Interface Builder.
- with the ClickWheel selected in the Connections Inspector ctrl-drag from "valueChanged" to your host view controller and create an @IBAction
- In this @IBAction you rely on the "angle" property of the ClickWheel to receive updates as the wheel is being dragged.
- DO NOT create an action for the click of the center button. This is done programmatically for you.

### The Click Sound
The ClickWheel of course comes with sound. But frankly, the sound really sucks. This is why it is disabled by default in debugging mode. I just haven't taken the time yet to dig up a nicer and more appropriate sound. But you can very easily change the sound by dropping in a different sound file and changing the file name and extension in the prepareSound() method. You may also find it necessary to adjust the frequence on which the played.

### MIT License
Copyright (c) 2015 Dirk Gerretz/[code2 app];
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
