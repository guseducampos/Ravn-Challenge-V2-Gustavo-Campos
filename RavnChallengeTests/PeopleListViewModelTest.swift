//
//  PeopleListViewModelTest.swift
//  RavnChallengeTests
//
//  Created by Gustavo Campos on 7/11/20.
//

import XCTest
@testable import RavnChallenge
import Combine

class PeopleListViewModelTest: XCTestCase {
    func testFetchWhenStateIsInitial() {
        // Given
        let viewModel = PeopleListViewModel(
            starWarsClient: StarWarsClient(
                people: { _ -> AnyPublisher<StarWarsResponse, Error> in
                    let response = StarWarsResponse(people: [
                        .init(id: .init())
                    ], pageInfo: .init(hasNextPage: true))
                return Just(response)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            })
        )

        // When
        viewModel.fetchPeople()

        // Then
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertFalse(viewModel.state.requestFailed)
        XCTAssertTrue(viewModel.state.continueFetching)
        XCTAssertEqual(viewModel.state.response.people.count, 1)
    }

    func testFetchWhenIsStillLoadingAPreviousOne() throws {
        // Given
        let viewModel = PeopleListViewModel(
            starWarsClient: StarWarsClient(
                people: { _ -> AnyPublisher<StarWarsResponse, Error> in
                   fatalError("Imposible State!, shouldn't reach here if is still loading")
            }),
            state: .init(
                response: .init(people: [],
                                pageInfo: .init(hasNextPage: true)),
                isLoading: true)
        )

        // When
        viewModel.fetchPeople()

        // Then
        XCTAssertTrue(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.continueFetching)
        XCTAssertFalse(viewModel.state.requestFailed)
        XCTAssertEqual(viewModel.state.response.people.count, 0)
    }

    func testFetchWhenThereAreNoElementsToRetreive() {
        // Given
        let viewModel = PeopleListViewModel(
            starWarsClient: StarWarsClient(
                people: { _ -> AnyPublisher<StarWarsResponse, Error> in
                   fatalError("Imposible State!, shouldn't reach here if there are no more elements to fetch")
            }),
            state: .init(
                response: .init(people: [.init(id: .init())],
                                pageInfo: .init(hasNextPage: false)),
                isLoading: false)
        )

        // When
        viewModel.fetchPeople()

        // Then
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertFalse(viewModel.state.continueFetching)
        XCTAssertFalse(viewModel.state.requestFailed)
        XCTAssertEqual(viewModel.state.response.people.count, 1)
    }

    func testLoadMoreContent() {
        // Given
        let person = Person(id: "5")
        let allPeople = [
            Person(id: "1"),
            Person(id: "2"),
            Person(id: "3"),
            Person(id: "4"),
            person,
            Person(id: "6"),
        ]

        let viewModel = PeopleListViewModel(
            starWarsClient: StarWarsClient(
                people: { _ -> AnyPublisher<StarWarsResponse, Error> in
                    let response = StarWarsResponse(people: [
                        .init(id: .init())
                    ], pageInfo: .init(hasNextPage: true))
                    return Just(response)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
            }),
            state: .init(
                response: .init(people: allPeople,
                                pageInfo: .init(hasNextPage: true)),
                isLoading: false)
        )

        // When
        viewModel.loadMoreContent(after: person)

        // Then
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertFalse(viewModel.state.requestFailed)
        XCTAssertTrue(viewModel.state.continueFetching)
        XCTAssertEqual(viewModel.state.response.people.count, 7)
    }

    func testWhenARequestFails() {
        // Given
        let viewModel = PeopleListViewModel(
            starWarsClient: StarWarsClient(
                people: { _ -> AnyPublisher<StarWarsResponse, Error> in
                    return Fail(error: NSError()).eraseToAnyPublisher()
            })
        )

        // When
        viewModel.fetchPeople()

        // Then
        XCTAssertFalse(viewModel.state.isLoading)
        XCTAssertTrue(viewModel.state.requestFailed)
        XCTAssertTrue(viewModel.state.continueFetching)
        XCTAssertEqual(viewModel.state.response.people.count, 0)
    }
}
