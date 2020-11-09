//
//  NavigationBarModifier.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 8/11/20.
//

import SwiftUI
import UIKit

/// SwiftUI Modifier that allows to change navigation bar tint color since apple doesn't an API for pure SwiftUI
/// Needs to be handle through UKit's API appeareance.
struct NavigationBarModifier: ViewModifier {
    init(titleColor: UIColor, backgroundColor: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = backgroundColor
        appearence.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]

        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
        UINavigationBar.appearance().compactAppearance = appearence
        UINavigationBar.appearance().tintColor = titleColor
    }

    func body(content: Content) -> some View {
        content
    }
}
