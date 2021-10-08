//
//  folderListViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/07.
//

import UIKit
import DropDown

class folderListViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerBackButton: UIButton!
    @IBOutlet weak var headerSettingButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var folderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidload")
        
        self.folderTableView.dataSource = self
        self.folderTableView.delegate = self
        

        
        self.headerImageView.layer.addBorder([.bottom], color: UIColor.white, width: 0.2)
        self.headerBackButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerSettingButton.imageEdgeInsets = UIEdgeInsets(top: 9, left: 11, bottom: 13, right: 11)
        self.moreButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        print("showDropDown")

        let dropDown = showDropDownMenu()
        dropDown.dataSource = ["폴더명 변경", "폴더 추가", "폴더 삭제"]
        dropDown.anchorView = self.moreButton
        dropDown.bottomOffset = CGPoint(x: -self.moreButton.bounds.width*2, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.show()
        
        print(dropDown.selectedItem)
    }
    
    
}

extension folderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! folderCell
        return cell
    }
    
    
}
