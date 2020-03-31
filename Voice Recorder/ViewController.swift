//
//  ViewController.swift
//  Voice Recorder
//
//  Created by Zackary O'Connor on 3/30/20.
//  Copyright © 2020 Zackary O'Connor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let recordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(startStopRecording), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupButtons()
    }
    
    
    private func setupButtons() {
        view.addSubview(recordButton)
        recordButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 24, right: 0))
        recordButton.centerXInSuperview()
        setButtonImageName("mic.fill")
    }
    
    
    private func setButtonImageName(_ imageName: String) -> String {
        let configuration = UIImage.SymbolConfiguration(pointSize: 42, weight: .thin, scale: .large)
        recordButton.setImage(UIImage(systemName: imageName, withConfiguration: configuration), for: .normal)
        return imageName
    }
    
    
    @objc private func startStopRecording() {
        if recordButton.isSelected == false {
            recordButton.isSelected = true
            setButtonImageName("stop.fill")
        } else {
            recordButton.isSelected = false
            setButtonImageName("mic.fill")
        }
    }
    
    
}

