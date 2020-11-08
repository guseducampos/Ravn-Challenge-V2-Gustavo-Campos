//
//  StarWarsService.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 7/11/20.
//

import Combine
import Foundation

typealias People = StarWarsQuery.Data.AllPerson
typealias Person = StarWarsQuery.Data.AllPerson.Person
typealias PageInfo = StarWarsQuery.Data.AllPerson.PageInfo

struct StarWarsResponse {
    var people: [Person]
    var pageInfo: PageInfo
}

struct StarWarsClient {
    var people: (StarWarsQuery) -> AnyPublisher<StarWarsResponse, Error>
}

extension StarWarsClient {
    static var live: Self {
        let service = StarWarsService(client: NetworkClient().fetch(query:))
        return .init(people: service.getAllPeople(query:))
    }
}

struct StarWarsService {
    let client: NetworkInterface<StarWarsQuery>

    func getAllPeople(query: StarWarsQuery) -> AnyPublisher<StarWarsResponse, Error> {
        client(query)
            .map { data -> StarWarsResponse in
                let people = data.allPeople?.people
                let pageInfo = data.allPeople?.pageInfo
                return StarWarsResponse(
                    people: people?.compactMap { $0 } ?? [],
                    pageInfo: pageInfo ?? PageInfo(hasNextPage: false, endCursor: nil)
                )
            }.eraseToAnyPublisher()
    }
}
