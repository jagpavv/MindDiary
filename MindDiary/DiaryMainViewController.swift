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
    // DiaryCards
    let pad = CGFloat(10)
    let totalHeight = diaryCardBaseView.frame.height
    let diaryCardWidth = diaryCardBaseView.frame.width
    let diaryCardHeight = (totalHeight - (pad * CGFloat(3 + 1))) / 3

    // Inside of DiaryCards (mood color view) = mcv
    let mcvWidth = diaryCardWidth / 4
    let mcvTotalHeight = diaryCardHeight

    for idx in 0..<kNumberOfDiaryCard {
      let x = CGFloat(0) * (diaryCardWidth + pad)
      let y = CGFloat(idx % 3) * (diaryCardHeight + pad)

      // DiaryCards
      let diaryCard = UIView(frame: CGRect(x: x, y: y, width: diaryCardWidth, height: diaryCardHeight))
      diaryCard.backgroundColor = UIColor.gray
      self.diaryCardBaseView.addSubview(diaryCard)

      // Inside of DiaryCards (mood color view) = mcv
      let mcv = UIView(frame: CGRect(x: 0, y: 0, width: mcvWidth, height: mcvTotalHeight))
      mcv.backgroundColor = UIColor.blue
      diaryCard.addSubview(mcv)
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

