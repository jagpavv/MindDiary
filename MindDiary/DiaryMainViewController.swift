import UIKit
import Foundation

let kNumberOfDiaryCard = 3
class DiaryMainViewController: UIViewController, UITextViewDelegate {

  var diaryCardView: UIView!
  @IBOutlet weak var diaryCardBaseView: UIView!

//  override func viewDidLoad() {
//    super.viewDidLoad()
//    showDiaryCard()
//  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDiaryCard()
//    showDiaryCard2()
  }

  func showDiaryCard() {
    let pad = CGFloat(10)

    // DiaryCards
    diaryCardView = UIView()
    let totalHeight = diaryCardBaseView.frame.height
    let diaryCardWidth = diaryCardBaseView.frame.width
    let diaryCardHeight = (totalHeight - (pad * CGFloat(3 + 1))) / 3

    // Inside of DiaryCards (mood color view) = mcv
    let mcvWidth = diaryCardWidth / 4
    let mcvTotalHeight = diaryCardHeight
//    let mcvColor : [CGColor] = [#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 1)]

    // text section
    let textViewWidth = (diaryCardWidth - ((pad * 2) + mcvWidth))
    let textViewHeight = (diaryCardHeight - (pad * 2))

    for idx in 0..<kNumberOfDiaryCard {
      let x = CGFloat(0) //     * (diaryCardWidth + pad)
      let y = CGFloat(idx % 3) * (diaryCardHeight + pad)

      // DiaryCards
      let diaryCard = UIView(frame: CGRect(x: x, y: y, width: diaryCardWidth, height: diaryCardHeight))
      diaryCard.layer.borderWidth = 1
      diaryCard.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
      self.diaryCardBaseView.addSubview(diaryCard)

      // Inside of DiaryCards (mood color view) = mcv
      let mcv = UIView(frame: CGRect(x: 0, y: 0, width: mcvWidth, height: mcvTotalHeight))
//      mcv.layer.backgroundColor = mcvColor[idx]
      mcv.layer.backgroundColor = DiaryMainView.init().moodColor[idx]
      diaryCard.addSubview(mcv)

      // text section
      let xx = mcvWidth + pad
      let yy = pad

      let textView = UITextView(frame: CGRect(x: xx, y: yy, width: textViewWidth, height: textViewHeight))
      textView.text = DiaryMainView.init().placeHolderTxt[idx]
      textView.textColor = UIColor.lightGray
      textView.becomeFirstResponder()
      textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)

      diaryCard.addSubview(textView)
    }
  }





//  func showDiaryCard2() {
//    diaryCardView = UIView()
//    let totalWidth = diaryCardBaseView.frame.width
//    let totalHeight = diaryCardBaseView.frame.height / 3
//
//    guard let diaryCardView = diaryCardView else { return }
//
//    diaryCardView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight)
//    diaryCardView.backgroundColor = UIColor.gray
////    if let diaryCardView = diaryCardView {
//      self.diaryCardBaseView?.addSubview(diaryCardView)
////  }
//  }
  }

