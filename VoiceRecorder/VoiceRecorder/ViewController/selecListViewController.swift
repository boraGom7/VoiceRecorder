//
//  selecListViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/12.
//

import UIKit
import RxSwift
import DropDown

class selecListViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerBackButton: UIButton!
    @IBOutlet weak var headerSettingButton: UIButton!
    
    @IBOutlet weak var selectAllButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerImageView.layer.addBorder([.bottom], color: UIColor.white, width: 0.2)
        self.headerBackButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerSettingButton.imageEdgeInsets = UIEdgeInsets(top: 9, left: 11, bottom: 13, right: 11)
        self.moreButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

        dropDownSelection
            .asObserver()
            .subscribe(onNext: { str in
                DispatchQueue.main.async {
                    switch str {
                    case "폴더명 변경":
                        self.editFolderUI()
                    case "폴더 추가":
                        let plusVC = self.storyboard?.instantiateViewController(withIdentifier: "plusID") as! plusViewController
                        plusVC.modalPresentationStyle = .overFullScreen
                        self.present(plusVC, animated: true, completion: nil)
                    case "폴더 삭제":
                        self.deleteFolderUI()
                    default:
                        print("empty str")
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        print("click moreButton")
        
        let dropDown = showDropDownMenu()
        dropDown.dataSource = ["폴더명", "폴더 추가", "폴더 삭제"]
        dropDown.anchorView = self.moreButton
        dropDown.bottomOffset = CGPoint(x: -self.moreButton.bounds.width*2, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.show()

        dropDown.selectionAction = { (index, item) in
            dropDownSelection.onNext(item)
            dropDown.clearSelection()
        }
    }
    
    func editFolderUI() {
        selectAllButton.isHidden = true
        selectAllButtonLeading.constant = -15
        titleLabel.text = "폴더명 변경"
    }

    func deleteFolderUI() {
        selectAllButton.isHidden = false
        selectAllButtonLeading.constant = 15
        titleLabel.text = "폴더 선택"
    }
}
