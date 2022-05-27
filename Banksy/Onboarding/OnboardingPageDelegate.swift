//
//  OnboardingPageDelegaet.swift
//  Banksy
//
//  Created by Krishna Venkatramani on 27/05/2022.
//

import Foundation

protocol OnboardingPageControllerDelegate:AnyObject{
    func handleNextPageRequest()
    func handlePrevPageRequest()
}
