import UIKit

enum MoodType{
  case bad
  case good
  case tomorrow
}

class DiaryMainView: UIView {

//  let mood: MoodType
  let moodColor: [CGColor] = [#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 1)]
  let placeHolderTxt = [
    "What is the most bad thing to you, today?",
    "Waht is the most happy thing to you, today?",
    "what will you do on tomorrow?"
  ]

}
