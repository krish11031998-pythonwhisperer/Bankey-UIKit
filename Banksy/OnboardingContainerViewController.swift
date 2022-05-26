//
//  OnboardingContainerViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class OnboardingContainerViewController: UIViewController {


    private var currentPage:UIViewController
    private var pageViewController:UIPageViewController
    private var nextButton:UIView? = nil
    private var prevButton:UIView? = nil
    private var pages = [UIViewController]()
    
    public var delegate:LoginAndOnboardingViewControllerDelegate? = nil
    
    private lazy var pageInfo:[(img:String,monologue:String)] = {
        return [
            (img:"delorean",monologue:"Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s."),
            (img:"thumbs",monologue:"Move your money around the world quickly and securely."),
            (img:"world",monologue:"Learn more at www.bankey.com.")
        ]
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = .init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        self.currentPage = UIViewController()
        
        self.pageViewController.view.backgroundColor = .purple
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.pageBuilder()
    }
    
    private func pageBuilder(){
        for count in 0..<pageInfo.count{
            let eachPage = pageInfo[count]
            let onBoardPage = OnboardingPageViewController(imgName: eachPage.img, monologue: eachPage.monologue, nextButton: count != pageInfo.count - 1, prevButton: count != 0)
            onBoardPage.delegate = self
            pages.append(onBoardPage)
        }
        
        if let firstPage = self.pages.first{
            self.currentPage = firstPage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let closeButton:CustomButton = CustomButton(buttonTitle: "Close")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.view.addSubview(self.closeButton)
        
        self.pageViewController.didMove(toParent: self)
        self.pageViewController.dataSource = self
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
        self.pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        self.currentPage = pages.first!
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    
    func setupLayout(){
        //pageViewController
        NSLayoutConstraint.activate([
            self.pageViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        
        //closeButton
        NSLayoutConstraint.activate([
            self.closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            self.closeButton.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            self.closeButton.heightAnchor.constraint(equalToConstant: 25),
            self.closeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    
    }
    
}


extension OnboardingContainerViewController:UIPageViewControllerDataSource{
    
    enum PageDirecton{
        case before
        case after
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.getAdjacentPage(pageDirection: .after,viewController:viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.getAdjacentPage(pageDirection: .before,viewController:viewController)
    }
    
    private func getAdjacentPage(pageDirection:PageDirecton,viewController vc:UIViewController) -> UIViewController?{
        switch pageDirection {
            case .before:
                guard let index = self.pages.firstIndex(of: vc), index - 1 >= 0 else {return nil}
                self.currentPage = self.pages[index - 1]
                return self.pages[index - 1]
            case .after:
                guard let index = self.pages.firstIndex(of: vc), index + 1 < self.pages.count else {return nil}
                self.currentPage = self.pages[index + 1]
                return self.pages[index + 1]
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.pages.firstIndex(of: self.currentPage) ?? 0
    }
    
}

//

extension OnboardingContainerViewController:OnboardingPageControllerDelegate{
    
    func handleNextPageRequest() {
        guard let nextVC = self.getAdjacentPage(pageDirection: .after, viewController: self.currentPage) else {return}
        self.pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
    
    func handlePrevPageRequest() {
        guard let prevVC = self.getAdjacentPage(pageDirection: .before, viewController: self.currentPage) else {return}
        self.pageViewController.setViewControllers([prevVC], direction: .reverse, animated: true, completion: nil)
    }
}
