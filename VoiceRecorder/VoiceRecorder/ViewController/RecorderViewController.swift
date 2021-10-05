//
//  RecoderViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/01.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    
    //MARK: -- IBOulet
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerListButton: UIButton!
    @IBOutlet weak var headerSettingButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var recorderBGView: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var pauseWidthConstraint: NSLayoutConstraint!
    
    //MARK: -- View
    override func viewDidLoad() {
        super.viewDidLoad()

        setMainBG()
        setMainUI()

    }

    //MARK: -- IBAction
    @IBAction func goWeather(_ sender: Any) {
        let weatherVC = storyboard?.instantiateViewController(withIdentifier: "weatherID") as! weatherViewController
        weatherVC.modalPresentationStyle = .fullScreen
        self.present(weatherVC, animated: true, completion: nil)
    }
    
    @IBAction func clickRecord(_ sender: Any) {
        self.pauseWidthConstraint.constant = (self.view.bounds.width - 50)/1.5
        UIView.animate(withDuration: 0.7, animations: {
            self.buttonStackView.layoutIfNeeded()
        }, completion: { _ in
            
        })

    }
    
    //MARK: -- Function
    
    /* 버튼 UI 레이아웃 */
    func setMainUI() {
        self.headerListButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerSettingButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerImageView.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.5)
        
        self.recorderBGView.layer.cornerRadius = 20
        self.recorderBGView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4.7).isActive = true
        
        self.recordButton.frame.size.width = (self.view.bounds.width - 50)/1.5
        self.pauseButton.layer.cornerRadius = 15
        self.recordButton.layer.cornerRadius = 15
    }
    
    /* 메인화면 그라디언트 + 메인 일러스트 */
    func setMainBG() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.mainImageView.bounds
        
        gradientLayer.colors = [UIColor(named: "mainTopColor")!.cgColor, UIColor(named: "mainMiddleColor")!.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.15, 0.4]
        self.mainImageView.layer.addSublayer(gradientLayer)
        
        let illustImageView = UIImageView()
        self.mainImageView.addSubview(illustImageView)
        
        if let illustImage = UIImage(named: "main_illust") {
            let ratio = illustImage.size.width / illustImage.size.height
            
            illustImageView.translatesAutoresizingMaskIntoConstraints = false
            illustImageView.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor).isActive = true
            illustImageView.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor).isActive = true
            illustImageView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor).isActive = true
            illustImageView.heightAnchor.constraint(equalToConstant: (illustImage.size.width / ratio)).isActive = true
            
            illustImageView.image = illustImage
        }
    }

}
