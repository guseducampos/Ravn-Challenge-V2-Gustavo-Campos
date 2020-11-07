//
//  ApolloClient.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 7/11/20.
//

import Apollo
import Combine
import Foundation

enum Constants {
    static let url = "https://swapi-graphql.netlify.app/.netlify/functions/index"
}

/// Apollo client interface
typealias NetworkInterface<T: GraphQLQuery> = (T) -> AnyPublisher<T.Data, Error>

struct GraphQLErrors: Error {
    let message: String
}

/// Apollo client implementation
final class NetworkClient {
    static let shared = NetworkClient()

    private lazy var apollo = ApolloClient(url: URL(string: Constants.url)!)

    func fetch<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error> {
        Future { [apollo] promise in
            apollo.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    if let data = graphQLResult.data {
                        promise(.success(data))
                    } else if let error = graphQLResult.errors {
                        let message =  error.map(\.localizedDescription).joined(separator: "\n")
                        promise(.failure(GraphQLErrors(message: message)))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
