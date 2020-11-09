//
//  PeopeListViewModel.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 7/11/20.
//

import Combine
import Foundation

final class PeopleListViewModel: ObservableObject {
    struct State {
        var response: StarWarsResponse
        var isLoading: Bool = false
        var requestFailed: Bool = false

        var continueFetching: Bool {
            response.pageInfo.hasNextPage
        }

        static var initial: Self {
            let pageInfo = PageInfo(hasNextPage: true)
            return State(response: .init(people: [], pageInfo: pageInfo))
        }
    }

    @Published var state: State
    private let starWarsClient: StarWarsClient
    var cancellable: AnyCancellable?

    init(starWarsClient: StarWarsClient,
         state: State = .initial) {
        self.starWarsClient = starWarsClient
        self.state = state
    }

    func fetchPeople() {
        guard !state.isLoading, state.continueFetching else {
            return
        }

        state.isLoading = true
        cancellable = starWarsClient
            .people(StarWarsQuery(first: 5, after: state.response.pageInfo.endCursor))
            .sink(receiveCompletion: {[weak self] result in
                self?.state.isLoading = false
                switch result {
                case .failure(_):
                    self?.state.requestFailed = true
                default:
                    break
                }
            }, receiveValue: {[weak self] response in
                self?.state.response.people.append(contentsOf: response.people)
                self?.state.response.pageInfo = response.pageInfo
                self?.state.requestFailed = false
            })
    }

    func loadMoreContent(after item: Person) {
        let endIndex = state.response.people.endIndex
        let threshold = state.response.people.index(endIndex, offsetBy: -2)
        let index =  state.response.people.firstIndex(where: { $0.id == item.id })
        if threshold == index {
            fetchPeople()
        }
    }
}
