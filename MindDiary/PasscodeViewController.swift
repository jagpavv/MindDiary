import UIKit
import Foundation
import CoreData

let ksavedPasscode = "userPasscode"
let maxPasscodeNum = 4

class PasscodeViewController: UIViewController {

  private var savedPasscode = [Int]()
  var inputPasscode = [Int]()

  // *** core data
  var storedPasscode: [NSManagedObject] = []

  @IBOutlet var pinIndicators: [PinIndicator]!

  //  let userDefault = UserDefaults.standard
  //  private var savedPasscode: [Int]? {
  //    get {
  //      return UserDefaults.standard.array(forKey: "userPasscode") as? [Int]
  //    }
  //    set {
  //      UserDefaults.standard.set(newValue, forKey: "userPasscode")
  //    }
  //  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

//  // *** core data
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//    let managedContext = appDelegate.persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
//
//    do {
//      storedPasscode = try managedContext.fetch(fetchRequest)
//    } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//    }
//  }



  // If user didn't set the passcode move to Diary main view
  override func viewDidAppear(_ animated: Bool) {
    if savedPasscode.isEmpty {
      let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
      guard let DiaryMainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DiaryMain") as? DiaryMainViewController else { return }
      present(DiaryMainViewController, animated: false, completion: nil)
    }
  }

  // Digit (0~9), cancel, delete Button
  @IBAction func btnTapped(_ sender: Button) {
    switch sender.tag {
    case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9:
      pinIndicators[inputPasscode.endIndex].isColored = true
      UIView.animate(withDuration: 0.3, animations: { self.fillupColor() }) { _ in
        self.checkPasscode(digit: sender.tag)
      }
      print(inputPasscode)
    case 100: // cancel
      clearAll()
    case 111: // delete
      clearOnebyOne()
    default:
      break
    }
  }

  func checkPasscode(digit: Int) {
//    do {
//      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//      let result = try managedContext.fetch(fetchRequest)
//      if (result.count < 1) {
//        createUser()
//      }
//    }
//    catch let error as NSError
//    {
//      print("Could not fetch: \(error)")
//    }


    inputPasscode.append(digit)
    if inputPasscode.count == savedPasscode.count {
      if inputPasscode == savedPasscode {
        performSegue(withIdentifier: "moveToDiaryMain", sender: nil)
        savedPasscode.removeAll()
        clearAll()
      } else {
        isIncorrectAnimation()
      }
    }
  }

  // Fill up the color when isColored is true.
  func fillupColor() {
    let isColoredTrueArr = pinIndicators.filter { $0.isColored == true }
    isColoredTrueArr.forEach { (p) in
      p.fillup()
    }
  }

  func clearAll() {
    inputPasscode.removeAll()
    pinIndicators.forEach { (placeHolder) in
      placeHolder.clear()
    }
  }

  func clearOnebyOne() {
    inputPasscode.removeLast()
    pinIndicators[inputPasscode.endIndex].clear()
  }

  func isIncorrectAnimation() {
    inputPasscode.removeAll()
    pinIndicators.forEach { (placeHolder) in
      placeHolder.shake()
      placeHolder.clear()
    }
  }
}
