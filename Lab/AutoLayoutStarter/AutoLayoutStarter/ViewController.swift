//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Modified by Kaden Kim on 2020-04-15.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mainView: UIView = {
        let main = UIView()
        // important when setting contraints programmatically
        main.translatesAutoresizingMaskIntoConstraints = false
        main.backgroundColor = .green
        return main
    }()
    
    let squareButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Square", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
        return butt
    }()
    
    let portraitButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Portrait", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
        return butt
    }()
    
    let landScapeButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Landscape", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
        return butt
    }()
    
    var widthAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?
    
    let purpleView: UIView = {
        let ppView = UIView(frame: .zero)
        ppView.translatesAutoresizingMaskIntoConstraints = false
        ppView.backgroundColor = .purple
        return ppView
    }()
    
    let squaresVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<3 {
            let blueSquare = UIView(frame: .zero)
            blueSquare.backgroundColor = .blue
            blueSquare.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(blueSquare)
            NSLayoutConstraint.activate([
                blueSquare.widthAnchor.constraint(equalToConstant: 50),
                blueSquare.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        return stackView
        
    }()
    
    let redSquaresView: UIView = {
        let space: CGFloat = 10
        let v1 = UIView(frame: .zero), v2 = UIView(frame: .zero)
        v1.backgroundColor = UIColor.init(red: 229 / 255.0, green: 122 / 255.0, blue: 58 / 255.0, alpha: 1.0)
        v1.translatesAutoresizingMaskIntoConstraints = false
        v2.backgroundColor = v1.backgroundColor
        v2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v1.widthAnchor.constraint(equalToConstant: 75),
            v1.heightAnchor.constraint(equalToConstant: 30),
            v2.widthAnchor.constraint(equalToConstant: 50),
            v2.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [v1, v2])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = space
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let bgView = UIView(frame: .zero)
        bgView.backgroundColor = UIColor.init(red: 222 / 255.0, green: 46 / 255.0, blue: 51 / 255.0, alpha: 1.0)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            bgView.widthAnchor.constraint(equalToConstant: 135 + space * 2),
            bgView.heightAnchor.constraint(equalToConstant: 30 + space * 2)
        ])
        
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        // Add the purple box
        mainView.addSubview(purpleView)
        NSLayoutConstraint.activate([
            purpleView.heightAnchor.constraint(equalToConstant: 50),
            purpleView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6),
            purpleView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
            purpleView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
        
        // Add UIStackView with vertically arranged three blue squares(UIView)
        mainView.addSubview(squaresVStackView)
        NSLayoutConstraint.activate([
            squaresVStackView.widthAnchor.constraint(equalToConstant: 50),
            squaresVStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
            squaresVStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            squaresVStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        
        // Add UIView including UIStackView with horizontally arranged two pink squares(UIView)
        mainView.addSubview(redSquaresView)
        NSLayoutConstraint.activate([
            redSquaresView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            redSquaresView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
        ])
        
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
        widthAnchor?.isActive = true
        
        heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
        heightAnchor?.isActive = true
        
        let buttStackView = UIStackView(arrangedSubviews: [
            squareButton, portraitButton, landScapeButton])
        buttStackView.translatesAutoresizingMaskIntoConstraints = false
        buttStackView.axis = .horizontal
        buttStackView.alignment = .center
        buttStackView.distribution = .fillEqually
        
        view.addSubview(buttStackView)
        NSLayoutConstraint.activate([
            buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttStackView.heightAnchor.constraint(equalToConstant: 50),
            buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc private func squareTapped() {
        view.layoutIfNeeded()
        let shorterDim = (self.view.bounds.size.width < self.view.bounds.size.height) ? self.view.widthAnchor : self.view.heightAnchor
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: shorterDim, multiplier: 0.7)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: shorterDim, multiplier: 0.7)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func portraitTapped() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func landscapeTapped() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            self.widthAnchor?.isActive = false
            self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
            self.heightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
    }
}

