//
//  RxModel.swift
//  VoiceRecorder
//
//  Created by mac on 2021/10/06.
//

import Foundation
import RxSwift

var isRecording = BehaviorSubject<Bool>(value: false)
var isSaved = BehaviorSubject<Bool>(value: false)
