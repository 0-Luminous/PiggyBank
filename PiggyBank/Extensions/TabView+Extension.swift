//
//  TabView+Extension.swift
//  PiggyBank
//
//  Created by Yan on 11/3/25.
//
import SwiftUI
import UIKit

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
