//
//  RecoderViewController.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/01.
//

import UIKit
import AVFoundation
import RxSwift

class RecorderViewController: UIViewController {
    var disposeBag = DisposeBag()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        isSaved.asObserver()
            .take(1)
            .subscribe(onNext: { isSaved in
                if isSaved {
                    self.showToast(message: "저장되었습니다.")
                }
            }).disposed(by: disposeBag)
        
    }

    //MARK: -- IBAction
    @IBAction func goWeather(_ sender: Any) {
        let weatherVC = storyboard?.instantiateViewController(withIdentifier: "weatherID") as! weatherViewController
        weatherVC.modalPresentationStyle = .fullScreen
        self.present(weatherVC, animated: true, completion: nil)
    }
    
    @IBAction func goList(_ sender: Any) {
        let folderListVC = storyboard?.instantiateViewController(withIdentifier: "folderID") as! folderListViewController
        folderListVC.modalPresentationStyle = .fullScreen
        self.present(folderListVC, animated: true, completion: nil)
    }
    
    @IBAction func clickRecord(_ sender: Any) {
        self.recordButton.setImage(UIImage(), for: .normal)
        self.recordButton.setTitle("", for: .normal)
        self.pauseButton.setImage(UIImage(), for: .normal)
        self.pauseButton.setTitle("", for: .normal)
        
        isRecording.asObserver()
            .take(1)
            .subscribe(onNext: { isRecording in
                DispatchQueue.main.async {
                    isRecording ? self.stopRecording() : self.startRecording()
                }
        }).disposed(by: disposeBag)

    }
    
    //MARK: -- Function
    
    //MARK: -- 레이아웃 변경 애니메이션
    //--------* 제약조건을 IBOulet으로 연결해서 constant 변경 */
    
    /* 녹음 시작 */
    func startRecording() {
        self.pauseWidthConstraint.constant = (self.view.bounds.width - 50)/1.5
        self.pauseButton.setTitle("  일시정지", for: .normal)
        self.pauseButton.backgroundColor = UIColor(named: "darkGrayColor")
        
        UIView.animate(withDuration: 0.6, animations: {
            self.buttonStackView.layoutIfNeeded()
            self.recordButton.setTitle("  중지", for: .normal)
            self.pauseButton.setTitle("", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.pauseButton.setTitle("  일시정지", for: .normal)
                self.pauseButton.setImage(UIImage(named: "s_pause_icon"), for: .normal)
                self.recordButton.setImage(UIImage(named: "s_stop_icon"), for: .normal)
            })
        }, completion: { _ in
            isRecording.onNext(true)
        })
    }
    
    /* 녹음 멈춤 */
    func stopRecording() {
        self.pauseWidthConstraint.constant = (self.view.bounds.width - 50)/3
        self.pauseButton.setTitle("  일시정지", for: .normal)
        self.pauseButton.backgroundColor = UIColor(named: "lightGrayColor")
        
        UIView.animate(withDuration: 0.6, animations: {
            self.buttonStackView.layoutIfNeeded()
            self.recordButton.setTitle("  녹음시작", for: .normal)
            self.pauseButton.setTitle("", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.pauseButton.setImage(UIImage(named: "s_pause_icon"), for: .normal)
                self.recordButton.setImage(UIImage(named: "s_stop_icon"), for: .normal)
                self.pauseButton.setTitle("  일시정지", for: .normal)
            })
        }, completion: { _ in
            isRecording.onNext(false)
            
            let saveFileVC = self.storyboard?.instantiateViewController(withIdentifier: "saveFileID") as! SaveFileViewController
            saveFileVC.modalPresentationStyle = .fullScreen
            self.present(saveFileVC, animated: true, completion: nil)
        })
    }
    
    /* 버튼 UI 레이아웃 */
    func setMainUI() {
        self.headerListButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerSettingButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 14, right: 12)
        self.headerImageView.layer.addBorder([.bottom], color: UIColor(named: "darkGrayColor")!, width: 0.5)
        
        self.recorderBGView.layer.cornerRadius = 20
        self.recorderBGView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/4.7).isActive = true
        
        self.pauseWidthConstraint.constant = (self.view.bounds.width - 50)/3
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
    
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 60, y: self.view.frame.size.height/1.5, width: 120, height: 35))
        toastLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut,
                       animations: {
            toastLabel.alpha = 0.0
        },
                       completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
