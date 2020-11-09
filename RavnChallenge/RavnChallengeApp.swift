//
//  RavnChallengeApp.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 7/11/20.
//

import SwiftUI

@main
struct RavnChallengeApp: App {
    @StateObject var viewModel = PeopleListViewModel(starWarsClient: .live)
    var body: some Scene {
        WindowGroup {
            PeopleListView(viewModel: viewModel)
        }
    }
}
