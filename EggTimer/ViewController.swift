//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

final class MainViewController: UIViewController {
    
    //MARK: - TIMER
    private var timer = Timer()
    private var player: AVAudioPlayer!
    private var totalTime = 0
    private var secondsPassed = 0

    //MARK: - UI
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let pView = UIProgressView()
        pView.backgroundColor = .systemGray3
        pView.tintColor = .systemYellow
        pView.progress = 0.5
        
        pView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pView)
        return pView
    }()
    
    //MARK: - egg labels
    
    private lazy var softlabel: UILabel = {
        let label = UILabel()
        label.text = "Soft"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mediumlabel: UILabel = {
        let label = UILabel()
        label.text = "Medium"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center

        return label
    }()
    
    private lazy var hardlabel: UILabel = {
        let label = UILabel()
        label.text = "Hard"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - egg buttons
    
    private lazy var softEgg: UIButton = {
        let button = UIButton()
        let img = UIImage(named: "soft_egg")
        button.setTitle("SOFT", for: .normal)
        button.setImage(img, for: .normal)
        button.addTarget(self,
                         action: #selector(softEggButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var mediumEgg: UIButton = {
        let button = UIButton()
        let img = UIImage(named: "medium_egg")
        button.setTitle("MEDIUM", for: .normal)
        button.setImage(img, for: .normal)
        button.addTarget(self,
                         action: #selector(mediumEggButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var hardEgg: UIButton = {
        let button = UIButton()
        let img = UIImage(named: "hard_egg")
        button.setTitle("HARD", for: .normal)
        button.setImage(img, for: .normal)
        button.addTarget(self,
                         action: #selector(hardEggButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - stack
    
    private lazy var eggStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [softEgg,
                                                   mediumEgg,
                                                   hardEgg])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        return stack
    }()
    
    private lazy var eggStackLabel: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [softlabel,
                                                   mediumlabel,
                                                   hardlabel])
        stack.axis = .horizontal
        stack.spacing = 70
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        return stack
    }()
    
    //MARK: - OBJC
    
    @objc
    private func softEggButtonTapped() {
        timer.invalidate()
        totalTime = 3
        progressView.progress = 0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc
    private func mediumEggButtonTapped() {
        timer.invalidate()
        totalTime = 4
        progressView.progress = 0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc
    private func hardEggButtonTapped() {
        timer.invalidate()
        totalTime = 7
        progressView.progress = 0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    //TIMER
    
    @objc
    private func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            label.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            progressView.heightAnchor.constraint(equalToConstant: 12),
            
            eggStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eggStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            softEgg.heightAnchor.constraint(equalToConstant: 120),
            softEgg.widthAnchor.constraint(equalToConstant: view.frame.width / 3.2),
            
            mediumEgg.heightAnchor.constraint(equalToConstant: 120),
            mediumEgg.widthAnchor.constraint(equalToConstant: view.frame.width / 3.2),

            hardEgg.heightAnchor.constraint(equalToConstant: 120),
            hardEgg.widthAnchor.constraint(equalToConstant: view.frame.width / 3.2),
            
            eggStackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            eggStackLabel.topAnchor.constraint(equalTo: eggStack.bottomAnchor, constant: 15),
        ])
    }
    

}

