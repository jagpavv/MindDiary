import UIKit

class PinIndicator: UIView {
  var isColored = false

  override func layoutSubviews() {
    super.layoutSubviews()
    basic()
  }

  func basic() {
    layer.cornerRadius = frame.width / 2
    layer.borderWidth = 2
    layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
  }

  func fillup() {
    layer.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
  }

  func clear() {
    layer.cornerRadius = frame.width / 2
    layer.borderWidth = 2
    layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    isColored = false
  }


  // Anmimation
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
  }
}

//extension UIView {
//  func shake() {
//    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
//    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//    animation.duration = 0.6
//    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
//    layer.add(animation, forKey: "shake")
//  }
//}
// which one is better? extension or function inside of class?????



/*
 1)set:
 enter your passcode to set

 2)confirm:
 enter you passcode to confirm

 3)change: enter old password - set - confirm
 enter you old passcode to reset


 4)worng
 enter you passcode

 worng wrong wrong


 5)enter
 enter your pass code
 */



