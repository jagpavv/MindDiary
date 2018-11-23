import UIKit
import Foundation

let kNumberOfDiaryCard = 3
class DiaryMainViewController: UIViewController, UITextViewDelegate {

  var diaryCardView: UIView!
  var moodColorView: UIView!
  var textView: UITextView!

  @IBOutlet weak var diaryCardBaseView: UIView!

//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDiaryCard()

    textViewDidBeginEditing(textView)
    textViewDidEndEditing(textView)
  }

  func showDiaryCard() {
    let pad = CGFloat(10)

    // 1 DiaryCards
    let totalHeight = diaryCardBaseView.frame.height
    let diaryCardWidth = diaryCardBaseView.frame.width
    let diaryCardHeight = (totalHeight - (pad * CGFloat(3 + 1))) / 3

    // 2 mood color view of DiaryCards
    let moodColorViewWidth = diaryCardWidth / 4
    let moodColorViewTotalHeight = diaryCardHeight

    // 3 text view of DiaryCards
    let textViewWidth = (diaryCardWidth - ((pad * 2) + moodColorViewWidth))
    let textViewHeight = (diaryCardHeight - (pad * 2))
    let xx = moodColorViewWidth + pad
    let yy = pad

    // draw views
    for idx in 0..<kNumberOfDiaryCard {
      let x = CGFloat(0)
      let y = CGFloat(idx % 3) * (diaryCardHeight + pad)

      // 1 DiaryCards
      diaryCardView = UIView()
      diaryCardView.frame = CGRect(x: x, y: y, width: diaryCardWidth, height: diaryCardHeight)
      diaryCardView.layer.borderWidth = 1
      diaryCardView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
      diaryCardBaseView.addSubview(diaryCardView)

      // 2 mood color view of DiaryCards
      moodColorView = UIView()
      moodColorView.frame = CGRect(x: 0, y: 0, width: moodColorViewWidth, height: moodColorViewTotalHeight)
      moodColorView.layer.backgroundColor = DiaryMainView.init().moodColor[idx]
      diaryCardView.addSubview(moodColorView)

      // 3 text view of DiaryCards
      textView = UITextView()
      textView.frame = CGRect(x: xx, y: yy, width: textViewWidth, height: textViewHeight)

      textView.delegate = self
      textView.becomeFirstResponder()

//      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)

      textView.text = DiaryMainView.init().placeHolderTxt[idx]
      textView.textColor = UIColor.lightGray
      diaryCardView.addSubview(textView)
    }
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Placeholder"
      textView.textColor = UIColor.lightGray
    }
  }

//  func placeCursorPosition(_ textView: UITextView) {
//    let startPosition: UITextPosition = textView.beginningOfDocument
//    let endPosition: UITextPosition = textView.endOfDocument
//    let selectedRange: UITextRange? = textView.selectedTextRange
//
//    if let selectedRange = textView.selectedTextRange {
//
//      let cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
//
//      print("\(cursorPosition)")
//    }
//  }

//  func showPlaceHolderText(replacementText inputedText: String) {
//    //    var currentText = textView.text
//    let updateText = ""
//
//    if updateText.isEmpty {
//      textView.text = "Zzzzzzzzzz"
//      textView.textColor = UIColor.lightGray
////      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//    }
//
//    if self.view.window != nil {
//      if textView.textColor == UIColor.lightGray && !inputedText.isEmpty {
//        textView.text.removeAll()
//        textView.textColor = UIColor.black
//        textView.text = inputedText
//        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      }
//    }
////    else if textView.textColor == UIColor.lightGray && !inputedText.isEmpty {
////      textView.text.removeAll()
////      textView.textColor = UIColor.black
////      textView.text = inputedText
////    }
//  }
//
//  func textViewDidChangeSelection(_ textView: UITextView) {
//    if self.view.window != nil {
//      if textView.textColor == UIColor.lightGray {
//        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      }
//    }
//  }


}


extension UITextViewDelegate {

}

