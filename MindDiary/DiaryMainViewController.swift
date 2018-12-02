import UIKit
import Foundation

let kNumberOfDiaryCard = 3
class DiaryMainViewController: UIViewController, UITextViewDelegate {

  var diaryCardView: UIView!
  var moodColorView: UIView!
  var textView: UITextView!
  var placeholderLabel : UILabel!

  var textVeiws: [UITextView] = []
  var placeholders: [UILabel] = []

  @IBOutlet weak var diaryCardBaseView: UIView!
  @IBOutlet weak var toolbarView: UIToolbar!


  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDiaryCard()
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

    // 4 placeholder label
    let placeholderLabelWidth = textViewWidth
    let placeholderLabelHeight = textViewHeight
    let xxx = xx
    let yyy = yy

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
      textView.delegate = self
      //      textView.becomeFirstResponder()
      textView.frame = CGRect(x: xx, y: yy, width: textViewWidth, height: textViewHeight)
      textView.textColor = UIColor.black
      textView.font = UIFont(name: "verdana", size: 18.0)
      textView.inputAccessoryView = toolbarView
      textVeiws.append(textView)
      textVeiws[0].becomeFirstResponder()
      diaryCardView.addSubview(textView)

      // 4 placeholder label
      placeholderLabel = UILabel()
      placeholderLabel.frame = CGRect(x: xxx, y: yyy, width: placeholderLabelWidth, height: placeholderLabelHeight)
      placeholderLabel.text = DiaryMainView.init().placeHolderTxt[idx]
      placeholderLabel.textColor = UIColor.lightGray
      placeholderLabel.textAlignment = .left
      placeholderLabel.numberOfLines = 0
      placeholderLabel.font = UIFont(name: "verdana", size: 18.0)
      placeholders.append(placeholderLabel)
      diaryCardView.addSubview(placeholderLabel)
    }
  }

  @IBAction func tappedDoneBtn(_ sender: UIBarButtonItem) {
    print("tapped Done")
  }


  func textViewDidChange(_ textView: UITextView) {
    if textView === textVeiws[0] {
      placeholders[0].isHidden = !textView.text.isEmpty
    } else if textView === textVeiws[1] {
      placeholders[1].isHidden = !textView.text.isEmpty
    } else {
      placeholders[2].isHidden = !textView.text.isEmpty
    }
  }
}

// ---------------

// this code works with textview.delegate = self, textView.becomeFirstResponder()
//  func textViewDidBeginEditing(_ textView: UITextView) {
//
//    if textView.text.count > 1 { //== DiaryMainView.init().placeHolderTxt[textView.tag]
//      textView.text = ""
////      placeholderLabel.isHidden = true
//      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//      textView.textColor = UIColor.black
//      textView.font = UIFont(name: "verdana", size: 18.0)
//    }
//  }

//  could use limit number of string
//  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    if text == "\n" {
//      textView.resignFirstResponder()
//    }
//    return true
//  }
//
//  func textViewDidEndEditing(_ textView: UITextView) {
//    if textView.text == "" {
//      textView.text = DiaryMainView.init().placeHolderTxt[textView.tag]
////      placeholderLabel.isHidden = true
//      textView.textColor = UIColor.lightGray
////      textView.font = UIFont(name: "verdana", size: 13.0)
//    }
//    textView.resignFirstResponder()
//  }

// --------------

//func textViewDidBeginEditing(_ textView: UITextView) {
//  textView.text = ""
//  textView.textColor = UIColor.black
//}
//
//func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//  if (text == "\n") {
//    textView.resignFirstResponder()
//    return false
//  }
//  return true
//}
