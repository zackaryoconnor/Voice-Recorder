//
//  PlayAudioController.swift
//  Voice Recorder
//
//  Created by Zackary O'Connor on 4/6/20.
//  Copyright © 2020 Zackary O'Connor. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioController: UIViewController {
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow, fast, chipmunk, vader, echo, reverb
    }
    
    let slowEffectButton = UIButton(title: "Slow", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let fastEffectButton = UIButton(title: "Fast", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let highPitchEffectButton = UIButton(title: "High Pitch", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let lowPitchEffectButton = UIButton(title: "Low Pitch", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let echoEffectButton = UIButton(title: "Echo", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let reverbEffectButton = UIButton(title: "Reverb", backgroundColor: .secondarySystemBackground, setTitleColor: .label, cornerRadius: 12)
    let stopEffectButton = UIButton(title: "Stop", backgroundColor: .systemRed, setTitleColor: .label, cornerRadius: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupButtons()
        setupAudio()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        
    }
    
    
    private func setupButtons() {
        let safeArea = view.safeAreaLayoutGuide
        let stackInset: CGFloat = 36
        let stackSpacing: CGFloat = 16
        let buttonSize: CGFloat = 125
        let stopEffectButtonHeight: CGFloat = 54
        
        slowEffectButton.constrainHeight(constant: buttonSize)
        slowEffectButton.constrainWidth(constant: buttonSize)
        slowEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        slowEffectButton.tag = 0
        
        fastEffectButton.constrainHeight(constant: buttonSize)
        fastEffectButton.constrainWidth(constant: buttonSize)
        fastEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        fastEffectButton.tag = 1
        
        highPitchEffectButton.constrainHeight(constant: buttonSize)
        highPitchEffectButton.constrainWidth(constant: buttonSize)
        highPitchEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        highPitchEffectButton.tag = 2
        
        lowPitchEffectButton.constrainHeight(constant: buttonSize)
        lowPitchEffectButton.constrainWidth(constant: buttonSize)
        lowPitchEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        lowPitchEffectButton.tag = 3
        
        echoEffectButton.constrainHeight(constant: buttonSize)
        echoEffectButton.constrainWidth(constant: buttonSize)
        echoEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        echoEffectButton.tag = 4
        
        reverbEffectButton.constrainHeight(constant: buttonSize)
        reverbEffectButton.constrainWidth(constant: buttonSize)
        reverbEffectButton.addTarget(self, action: #selector(playAudioButtonPressed), for: .touchUpInside)
        reverbEffectButton.tag = 5
        
        stopEffectButton.constrainHeight(constant: stopEffectButtonHeight)
        stopEffectButton.addTarget(self, action: #selector(stopAudioButtonPressed), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [slowEffectButton, fastEffectButton], customSpacing: 16, axis: .horizontal),
                                                   UIStackView(arrangedSubviews: [highPitchEffectButton, lowPitchEffectButton], customSpacing: stackSpacing, axis: .horizontal),
                                                   UIStackView(arrangedSubviews: [echoEffectButton, reverbEffectButton], customSpacing: stackSpacing, axis: .horizontal)],
                                customSpacing: stackSpacing)
        
        [stack, stopEffectButton].forEach { view.addSubview($0) }
        stack.fillSuperview(padding: .init(top: stackInset, left: stackInset, bottom: stopEffectButtonHeight  + stackSpacing + stackInset, right: stackInset))
        
        
        
        stopEffectButton.anchor(top: nil, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: stackSpacing, bottom: stackSpacing, right: stackSpacing))
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        view.invalidateIntrinsicContentSize()
        
    }
    
    
    @objc func playAudioButtonPressed(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    
    @objc func stopAudioButtonPressed() {
        stopAudio()
    }
    
}
