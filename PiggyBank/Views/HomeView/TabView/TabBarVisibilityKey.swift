//
//  TabBarVisibilityKey.swift
//  PiggyBank
//
//  Created by Yan on 13/3/25.
//
import SwiftUI

struct TabBarVisibilityKey: EnvironmentKey {
    static var defaultValue: TabBarVisibility = TabBarVisibility()
}

extension EnvironmentValues {
    var tabBarVisibility: TabBarVisibility {
        get { self[TabBarVisibilityKey.self] }
        set { self[TabBarVisibilityKey.self] = newValue }
    }
}

class TabBarVisibility {
    private var isHidden: Bool = false

    func hide() {
        isHidden = true
    }

    func show() {
        isHidden = false
    }

    var hidden: Bool {
        isHidden
    }
}
