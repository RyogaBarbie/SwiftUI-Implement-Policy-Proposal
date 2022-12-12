//
//  FeatureProviderProtocol.swift
//  SwiftConcurrencySample
//
//  Created by yamamura ryoga on 2022/07/14.
//

import Foundation
import UIKit

@MainActor
public protocol FeatureProviderProtocol {
    func build(
        _ request: TimelineViewRequest
    ) -> UIViewController
    
    func build(
        _ request: EdiitProfileViewRequest
    ) -> UIViewController
}
