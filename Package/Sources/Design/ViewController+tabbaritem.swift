//
//  ViewController+tabbaritem.swift
//  SwiftConcurrencySample
//
//  Created by yamamura ryoga on 2022/07/13.
//

import Foundation
import UIKit

extension UIViewController {
    public func setupTabBarItem(
        title: String,
        image: UIImage?
    ) {
        tabBarItem = UITabBarItem()
        tabBarItem.title = title
        if let _image = image {
            tabBarItem.image = _image.withRenderingMode(.alwaysTemplate)
            tabBarItem.selectedImage = _image.withRenderingMode(.alwaysTemplate)
        }
    }
}
