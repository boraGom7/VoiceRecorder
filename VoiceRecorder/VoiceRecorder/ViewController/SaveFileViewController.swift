//
//  FileInfoViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/06.
//

import UIKit

class SaveFileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: -- 버튼 터치 영역 확장
extension UIButton {
  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let margin: CGFloat = 44
    let hitArea = self.bounds.insetBy(dx: -margin, dy: -margin)
    return hitArea.contains(point)
  }
}
