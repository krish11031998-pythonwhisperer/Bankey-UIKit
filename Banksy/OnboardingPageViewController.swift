//
//  OnboardingPageViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class OnboardingPageViewController: UIViewController {

    private var nextButton:UIView? = nil
    private var prevButton:UIView? = nil

    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        return imageView
    }()

    private let monologueTextView:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.numberOfLines = 0

        return textView
    }()


    init(imgName:String,monologue:String,nextButton:Bool = false,prevButton:Bool = false){
        super.init(nibName: nil, bundle: nil)
        if nextButton{
            self.nextButton = CustomButton(buttonTitle: "Next")
        }
        if prevButton{
            self.prevButton = CustomButton(buttonTitle: "Prev")
        }
        self.imageView.image = .init(named: imgName)
        self.monologueTextView.text = monologue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.monologueTextView)

        self.view.addSubview(self.stackView)

        if let prevButton = prevButton {
            self.view.addSubview(prevButton)
        }

        if let nextButton = nextButton {
            self.view.addSubview(nextButton)
        }
        
        self.setupLayout()
        
    }


    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 25
        
        return stack
    }()


    func setupLayout(){

        //InfoStack
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])

        //Prev Button
        if let safePrevButton = self.prevButton{
            NSLayoutConstraint.activate([
                safePrevButton.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 1),
                self.view.bottomAnchor.constraint(equalToSystemSpacingBelow: safePrevButton.bottomAnchor, multiplier: 1),
                safePrevButton.widthAnchor.constraint(equalToConstant: 45),
                safePrevButton.heightAnchor.constraint(equalToConstant: 25)
            ])
        }

        //Next Button
        if let safeNextButton = self.nextButton{
            NSLayoutConstraint.activate([
                self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: safeNextButton.trailingAnchor, multiplier: 1),
                self.view.bottomAnchor.constraint(equalToSystemSpacingBelow: safeNextButton.bottomAnchor, multiplier: 1),
                safeNextButton.widthAnchor.constraint(equalToConstant: 45),
                safeNextButton.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
    }



}
