import UIKit
import Foundation

let kNumberOfDiaryCard = 3
class DiaryMainViewController: UIViewController {

  var diaryCardView: UIView!
  @IBOutlet weak var diaryCardBaseView: UIView!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDiaryCard()
//    showDiaryCard2()
  }

  func showDiaryCard() {
    let pad = CGFloat(10)

    // DiaryCards
    let totalHeight = diaryCardBaseView.frame.height
    let diaryCardWidth = diaryCardBaseView.frame.width
    let diaryCardHeight = (totalHeight - (pad * CGFloat(3 + 1))) / 3

    // Inside of DiaryCards (mood color view) = mcv
    let mcvWidth = diaryCardWidth / 4
    let mcvTotalHeight = diaryCardHeight

    // text section
    let textViewWidth = (diaryCardWidth - ((pad * 2) + mcvWidth))
    let textViewHeight = (diaryCardHeight - (pad * 2))

    for idx in 0..<kNumberOfDiaryCard {
      let x = CGFloat(0) //     * (diaryCardWidth + pad)
      let y = CGFloat(idx % 3) * (diaryCardHeight + pad)

      // DiaryCards
      let diaryCard = UIView(frame: CGRect(x: x, y: y, width: diaryCardWidth, height: diaryCardHeight))
      diaryCard.backgroundColor = UIColor.gray
      self.diaryCardBaseView.addSubview(diaryCard)

      // Inside of DiaryCards (mood color view) = mcv
      let mcv = UIView(frame: CGRect(x: 0, y: 0, width: mcvWidth, height: mcvTotalHeight))
      mcv.backgroundColor = UIColor.blue
      diaryCard.addSubview(mcv)

      // text section
      let xx = mcvWidth + pad
      let yy = pad

      let textView = UITextView(frame: CGRect(x: xx, y: yy, width: textViewWidth, height: textViewHeight))
      textView.backgroundColor = #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1)
      diaryCard.addSubview(textView)
    }
  }





//  func showDiaryCard2() {
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

