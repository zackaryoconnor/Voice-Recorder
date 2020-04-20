//
//  ViewController.swift
//  Voice Recorder
//
//  Created by Zackary O'Connor on 3/30/20.
//  Copyright © 2020 Zackary O'Connor. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!
    var recordingSession: AVAudioSession!
    
    let displayLabel = UILabel(text: "Press the microphone below to start recording a message.", textColor: .secondaryLabel, fontSize: 24, fontWeight: .medium, textAlignment: .center)
    
    let recordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(startStopRecording), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        checkPermission()
        setupView()
    }
    
    
    private func setupView() {
        [displayLabel, recordButton].forEach { view.addSubview($0) }
        
        let padding: CGFloat = 16
        displayLabel.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
        recordButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 24, right: 0))
        recordButton.centerXInSuperview()
        setButtonImageName("mic.fill")
    }
    
    
    private func checkPermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            break
        case AVAudioSessionRecordPermission.denied:
            recordButton.isEnabled = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    print("Allowed")
                } else {
                    print("Not allowed")
                }
            })
            break
        default:
            break
        }
    }
    
    
    @discardableResult private func setButtonImageName(_ imageName: String) -> String {
        let configuration = UIImage.SymbolConfiguration(pointSize: 42, weight: .thin, scale: .large)
        recordButton.setImage(UIImage(systemName: imageName, withConfiguration: configuration), for: .normal)
        return imageName
    }
    
    
    @objc private func startStopRecording() {
        if recordButton.isSelected == false {
            recordButton.isSelected = true
            setButtonImageName("stop.fill")
            recordAudio()
        } else {
            recordButton.isSelected = false
            setButtonImageName("mic.fill")
            stopRecording()
        }
    }
    
    
    @objc func recordAudio() {
        let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [directoryPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    
    @objc func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
}




extension RecordAudioController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            passAudio(self.audioRecorder.url)
        }
    }
    
    
    func passAudio(_ sender: Any?) {
        let playAudioController = PlayAudioController()
        let recordedAudioURL = sender as! URL
        playAudioController.recordedAudioURL = recordedAudioURL
        present(playAudioController, animated: true)
    }
}

