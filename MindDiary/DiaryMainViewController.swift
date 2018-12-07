import UIKit
import CoreData
import Foundation

let kNumberOfDiaryCard = 3
let kPlaceHolderTxt = [
  "What is \nthe most bad \nthing to you, today?",
  "Waht is \nthe most happy \nthing to you, today?",
  "what will \nyou do tomorrow?"
]
class DiaryMainViewController: UIViewController, UITextViewDelegate {

  var diaryCardView: UIView!
  var moodColorView: UIView!
  var textView: UITextView!
  var placeholderLabel : UILabel!
  var saveButton: UIButton!

  var textVeiws: [UITextView] = []
  var placeholders: [UILabel] = []

//  var diary: DiaryContent?
  var diaryContents: [NSManagedObject] = []

  var textBad = ""
  var textGood = ""
  var textTomorrow = ""

  @IBOutlet weak var diaryCardBaseView: UIView!
  @IBOutlet weak var toolbarView: UIToolbar!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDiaryCard()
    loadFromCoreData()

    // show stored diary content
    let storedDiary = diaryContents[0]
    textVeiws[0].text = storedDiary.value(forKeyPath: "bad") as? String
    textVeiws[1].text = storedDiary.value(forKeyPath: "good") as? String
    textVeiws[1].text = storedDiary.value(forKeyPath: "tomorrow") as? String
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
    let textViewX = moodColorViewWidth + pad
    let textViewY = pad

    // save button
    let saveBtnWidth = textViewWidth
    let savebtnHeight = CGFloat(30)
    let saveBtnX = CGFloat(0)
    let saveBtnY = textViewHeight - savebtnHeight

    // 4 placeholder label
    let placeholderLabelWidth = textViewWidth
    let placeholderLabelHeight = textViewHeight
    let placeholderLabelX = textViewX
    let placeholderLabelY = textViewY

    // draw views
    for idx in 0..<kNumberOfDiaryCard {
      let diaryCardX = CGFloat(0)
      let diaryCardY = CGFloat(idx % 3) * (diaryCardHeight + pad)

      // 1 DiaryCards
      diaryCardView = UIView()
      diaryCardView.frame = CGRect(x: diaryCardX, y: diaryCardY, width: diaryCardWidth, height: diaryCardHeight)
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
      textView.frame = CGRect(x: textViewX, y: textViewY, width: textViewWidth, height: textViewHeight)
      textView.textColor = UIColor.black
      textView.font = UIFont(name: "verdana", size: 18.0)
      textView.inputAccessoryView = toolbarView

      // save button
      saveButton = UIButton()
      saveButton.tag = idx
      saveButton.frame = CGRect(x: saveBtnX, y: saveBtnY, width: saveBtnWidth, height: savebtnHeight)
      saveButton.backgroundColor = UIColor.lightGray
      saveButton.setTitle("save", for: .normal)
      saveButton.addTarget(self, action: #selector(tappedSaveBtn), for: .touchUpInside)
      textView.addSubview(saveButton)

      textVeiws.append(textView)
      textVeiws[0].becomeFirstResponder() 
      diaryCardView.addSubview(textView)

      // 4 placeholder label
      placeholderLabel = UILabel()
      placeholderLabel.frame = CGRect(x: placeholderLabelX, y: placeholderLabelY, width: placeholderLabelWidth, height: placeholderLabelHeight)
      placeholderLabel.text = kPlaceHolderTxt[idx]
      placeholderLabel.textColor = UIColor.lightGray
      placeholderLabel.textAlignment = .left
      placeholderLabel.numberOfLines = 0
      placeholderLabel.font = UIFont(name: "verdana", size: 18.0)
      placeholders.append(placeholderLabel)
      diaryCardView.addSubview(placeholderLabel)
    }
  }

  @objc func tappedSaveBtn(sender: UIButton!) {
    saveToCoreData(content: textVeiws[sender.tag].text, btnTag: sender.tag)

    let storedDiary = diaryContents[0]
    var oldContent: String?
//    var currentTxt: String?
//    currentTxt = textVeiws[sender.tag].text

    if sender.tag == 0 {
//      currentTxt = textVeiws[0].text
      oldContent = storedDiary.value(forKeyPath: "bad") as? String
      if let oldContent = oldContent {
        updateToCoreData(content: textBad, oldContent: oldContent, btnTag: sender.tag)
        print(oldContent)
      }
    } else if sender.tag == 1 {
//      currentTxt = textVeiws[1].text
      oldContent = storedDiary.value(forKeyPath: "good") as? String
      if let oldContent = oldContent {
        updateToCoreData(content: textGood, oldContent: oldContent, btnTag: sender.tag)
        print(oldContent)
      }
    } else if sender.tag == 2 {
//      currentTxt = textVeiws[2].text
      oldContent = storedDiary.value(forKeyPath: "tomorrow") as? String
      if let oldContent = oldContent {
        updateToCoreData(content: textTomorrow, oldContent: oldContent, btnTag: sender.tag)
        print(oldContent)
      }
    }

//    if let oldContent = oldContent, let currentTxt = currentTxt {
//      updateToCoreData(content: currentTxt, oldContent: oldContent)
//      print(oldContent)
//    }

//    var txt: String {
//      get {
//        return oldContent
//      }
//      set {
//        switch sender.tag {
//        case 0:
//          storedDiary.value(forKeyPath: "bad") as? String
//        case 1:
//          storedDiary.value(forKeyPath: "good") as? String
//        case 2:
//          storedDiary.value(forKeyPath: "tomorrow") as? String
//        default:
//          break
//        }
//      }
//    }

//
//    if let oldcontent = oldContent {
//    updateToCoreData(content: textVeiws[sender.tag].text, oldContent: oldContent)
//    }


    print(sender.tag)
    print("saveBtnTapped")
    }

  @IBAction func tappedDoneBtn(_ sender: UIBarButtonItem) { // location: above the keyboard
    print("tapped Done")
  }

  //create? or save?
  func saveToCoreData(content: String, btnTag: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    let managedContext = appDelegate.persistentContainer.viewContext // viewContext only use main thread
    let entity = NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)!
    let newDiary = NSManagedObject(entity: entity, insertInto: managedContext)
    //    newDiary.setValue(content, forKeyPath: "bad")
    //
    //    do {
    //      try managedContext.save()
    //      diaryContents.append(newDiary)
    //    } catch let error as NSError {
    //      print("Could not save. \(error), \(error.userInfo)")
    //    }

    switch btnTag {
    case 0:
      newDiary.setValue(content, forKeyPath: "bad")
    case 1:
      newDiary.setValue(content, forKeyPath: "good")
    case 2:
      newDiary.setValue(content, forKeyPath: "tomorrow")
    default:
      break
    }
    do {
      try managedContext.save()
      diaryContents.append(newDiary)
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func loadFromCoreData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")

    do {
      diaryContents = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }

  func updateToCoreData(content: String, oldContent: String, btnTag: Int) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext

    switch btnTag {
    case 0:
      let fetchRequest0 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
      fetchRequest0.predicate = NSPredicate(format: "bad = %@", oldContent)
      do {
        let content0 = try managedContext.fetch(fetchRequest0)
        let objectUpdate0 = content0[0]
        objectUpdate0.setValue(content, forKeyPath: "bad")
        do {
          try managedContext.save()
        }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    case 1:
      let fetchRequest1 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
      fetchRequest1.predicate = NSPredicate(format: "good = %@", oldContent)
      do {
        let content1 = try managedContext.fetch(fetchRequest1)
        let objectUpdate1 = content1[0]
        objectUpdate1.setValue(content, forKeyPath: "good")
        do {
          try managedContext.save()
        }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    case 2:
      let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
      fetchRequest2.predicate = NSPredicate(format: "tomorrow = %@", oldContent)
      do {

        let content2 = try managedContext.fetch(fetchRequest2)
        let objectUpdate2 = content2[0]
        objectUpdate2.setValue(content, forKeyPath: "tomorrow")
        do {
          try managedContext.save()
        }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    default:
      break
    }

//    let fetchRequest1 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
//    fetchRequest1.predicate = NSPredicate(format: "bad = %@", oldContent)
//
//    let fetchRequest2 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
//    fetchRequest2.predicate = NSPredicate(format: "good = %@", oldContent)
//
//    let fetchRequest3 = NSFetchRequest<NSManagedObject>(entityName: "Diary")
//    fetchRequest3.predicate = NSPredicate(format: "tomorrow = %@", oldContent)

//    do {
//      let content1 = try managedContext.fetch(fetchRequest1)
//      let content2 = try managedContext.fetch(fetchRequest2)
//      let content3 = try managedContext.fetch(fetchRequest3)
//
//      let objectUpdate1 = content1[0]
//      let objectUpdate2 = content2[0]
//      let objectUpdate3 = content3[0]
//
//      //      let objectUpdate = test[0] as! NSManagedObject
//      objectUpdate1.setValue(content, forKeyPath: "bad")
//      objectUpdate2.setValue(content, forKeyPath: "good")
//      objectUpdate3.setValue(content, forKeyPath: "tomorrow")
//      do {
//        try managedContext.save()
//      }
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//    }
  }

//    switch guess.count {
//    case 0:
//      firstGuessButton?.value = CardButton.unusedValue
//      secondGuessButton?.value = CardButton.unusedValue
//    case 1:
//      firstGuessButton?.value = guess[0]
//      secondGuessButton?.value = CardButton.unusedValue
//    case 2:
//      firstGuessButton?.value = guess[0]
//      secondGuessButton?.value = guess[1]
//    default:
//      break
//    }
//    playSound(soundName: "sound0")
//    moveTo()
//  }

  func textViewDidChange(_ textView: UITextView) {
    if textView === textVeiws[0] {
      textBad = textView.text
      placeholders[0].isHidden = !textView.text.isEmpty
    } else if textView === textVeiws[1] {
      if textView === textVeiws[0] {
        textGood = textView.text
      placeholders[1].isHidden = !textView.text.isEmpty
    } else {
        textTomorrow = textView.text
      placeholders[2].isHidden = !textView.text.isEmpty
    }
  }


//  func textViewDidBeginEditing(_ textView: UITextView) {
//    currentTxt = textView.text
//  }
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
