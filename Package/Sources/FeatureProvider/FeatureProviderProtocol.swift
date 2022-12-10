//
//  FeatureProviderProtocol.swift
//  SwiftConcurrencySample
//
//  Created by yamamura ryoga on 2022/07/14.
//

import Foundation
import UIKit

@MainActor
protocol FeatureProviderProtocol {
    func build(
        _ request: SearchRepositoryViewRequest
    ) -> UIViewController
    
    func build(
        _ request: StaredRepositoryViewRequest
    ) -> UIViewController
}
