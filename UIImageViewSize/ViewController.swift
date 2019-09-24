//
// Copyright (c) 2019, mycompany All rights reserved. 
//

import UIKit

class ViewController: UIViewController {

  lazy var imagePortrait = UIImage(named: "imagePortrait")
  lazy var imageLandscape = UIImage(named: "imageLandscape")
  enum ImageType:Int {
    case portrait
    case landscape
  }

  let imageViewHMargin:CGFloat = 24.0
  let animationDuration:TimeInterval = 0.5
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
  @IBOutlet weak var segment: UISegmentedControl!
  override func viewDidLoad() {
    super.viewDidLoad()

    imageView.layer.borderWidth = 0
    imageView.layer.borderColor = UIColor.systemGray.cgColor
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true

    segment.selectedSegmentIndex = 0
    self.fitViewToUIImage()
  }

  func fitViewToUIImage(){
    guard let image = imageView.image else {return}

    let targetWidth = view.frame.width - imageViewHMargin * 2

    let rate =   targetWidth / image.size.width
    let height = image.size.height * rate
    imageViewHeight.constant = height


    UIView.animate(withDuration: animationDuration){
      self.view.layoutIfNeeded()
    }


  }
  @IBAction func onSegmentChange(_ sender: Any) {

    guard let imageType = ImageType(rawValue: segment.selectedSegmentIndex) else {return}

    UIView.transition(with: imageView,
                      duration: animationDuration,
                      options: .transitionCrossDissolve,
                      animations: {
                        switch imageType {
                        case .portrait:
                          self.imageView.image = self.imagePortrait
                        case .landscape:
                          self.imageView.image = self.imageLandscape
                        }},
                      completion: nil)

    self.fitViewToUIImage()
  }
}
