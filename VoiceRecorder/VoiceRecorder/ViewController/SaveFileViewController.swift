//
//  FileInfoViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/06.
//

import UIKit
import MapKit
import RxSwift

class SaveFileViewController: UIViewController {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var folderMenuButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dBLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerImageView.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.2)
        self.checkButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 8, right: 10)
        self.backButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 8, right: 6)
        
        self.folderMenuButton.layer.borderWidth = 0.5
        self.folderMenuButton.layer.borderColor = UIColor(named: "darkGrayColor")?.cgColor
        self.folderMenuButton.layer.cornerRadius = 6
        self.folderMenuButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        self.folderMenuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.view.bounds.width/1.6, bottom: 0, right: 0)
        
        
        self.nameTextField.frame = CGRect(origin: self.nameTextField.frame.origin, size: CGSize(width: self.view.bounds.width - 50, height: self.nameTextField.bounds.height))
        self.nameTextField.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.5)
        self.locationTextField.frame = CGRect(origin: self.nameTextField.frame.origin, size: CGSize(width: self.view.bounds.width - 50, height: self.nameTextField.bounds.height))
        self.locationTextField.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.5)
        self.memoTextField.frame = CGRect(origin: self.nameTextField.frame.origin, size: CGSize(width: self.view.bounds.width - 50, height: self.nameTextField.bounds.height))
        self.memoTextField.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.5)
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        isSaved.onNext(true)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: -- 버튼 터치 영역 확장
extension UIButton {
  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let margin: CGFloat = 44
    let hitArea = self.bounds.insetBy(dx: -margin, dy: -margin)
    return hitArea.contains(point)
  }
}
