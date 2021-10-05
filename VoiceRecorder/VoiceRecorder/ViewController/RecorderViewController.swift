//
//  RecoderViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/01.
//

import UIKit

class RecorderViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerListButton: UIButton!
    @IBOutlet weak var headerSettingButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var recorderBGView: UIImageView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var pauseWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        setMainBG()



    }

    @IBAction func goWeather(_ sender: Any) {
        let weatherVC = storyboard?.instantiateViewController(withIdentifier: "weatherID") as! ViewController
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
    
    func setMainUI() {
        self.headerListButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        self.headerSettingButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        self.recorderBGView.layer.cornerRadius = 20
        self.recorderBGView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4.7).isActive = true
        
        self.recordButton.frame.size.width = (self.view.bounds.width - 50)/1.5
        self.pauseButton.layer.cornerRadius = 15
        self.recordButton.layer.cornerRadius = 15
    }
    
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
