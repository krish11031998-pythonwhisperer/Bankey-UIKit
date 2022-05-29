//
//  ShakeyBell.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 29/05/2022.
//

import Foundation
import UIKit

class ShakeyBell:UIView{
    
    private let shakeyBellComponent:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let img = UIImage(systemName: "bell.fill") else{
            return imageView
        }
        imageView.image = img.withTintColor(.white,renderingMode:.alwaysOriginal)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let badge:UIButton = {
        let button = UIButton()
        button.setTitle("6", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setupLayout()
    }
    
    override var intrinsicContentSize: CGSize{
        return .init(width: 48, height: 48)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        self.addSubview(self.shakeyBellComponent)
        self.addSubview(self.badge)
        self.shakeyBellComponent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.shakeyBellTapped)))
        self.shakeyBellComponent.isUserInteractionEnabled = true
    }
    
    func setupLayout(){
        self.shakeyBellComponent.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.shakeyBellComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.shakeyBellComponent.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.shakeyBellComponent.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.badge.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.badge.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.badge.centerYAnchor.constraint(equalTo: self.shakeyBellComponent.centerYAnchor,constant: -7.5).isActive = true
        self.badge.leadingAnchor.constraint(equalTo: self.shakeyBellComponent.trailingAnchor, constant: -10).isActive = true
        
        self.badge.layer.cornerRadius = 10
    }
    
    
}


// MARK: - Actions
extension ShakeyBell {
    @objc func shakeyBellTapped(_ recognizer: UITapGestureRecognizer) {
        shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
    }

    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        self.shakeyBellComponent.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))

        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [],
          animations: {
            for count in 0..<Int(numberOfFrames){
                UIView.addKeyframe(withRelativeStartTime: frameDuration*Double(count),
                                   relativeDuration: frameDuration) {
                    if count != Int(numberOfFrames - 1){
                        self.shakeyBellComponent.transform = CGAffineTransform(rotationAngle: count%2 == 0 ? -angle : angle)
                    }else{
                        self.shakeyBellComponent.transform = CGAffineTransform.identity
                    }
                    
                }
            }
          },
          completion: nil
        )
    }
}
