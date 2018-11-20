import UIKit

class Button: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = frame.width / 2
    layer.borderWidth = 2
    layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
  }
}
