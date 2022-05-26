//
//  OnboardingContainerViewController.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 26/05/2022.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    private var pages = [UIViewController]()
    private var currentPage:UIViewController
    private var pageViewController:UIPageViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.pageViewController = .init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.pages = [OnboardingPageViewController(color: .red),OnboardingPageViewController(color: .green),OnboardingPageViewController(color: .blue)]
        
        self.currentPage = self.pages.first!
        
        self.pageViewController.view.backgroundColor = .purple
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
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
