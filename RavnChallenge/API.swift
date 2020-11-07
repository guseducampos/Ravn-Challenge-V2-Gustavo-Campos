// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class StarWarsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query StarWars($cursor: String) {
      allPeople(after: $cursor) {
        __typename
        pageInfo {
          __typename
          hasNextPage
        }
        people {
          __typename
          name
          eyeColor
          hairColor
          skinColor
          birthYear
          vehicleConnection {
            __typename
            vehicles {
              __typename
              id
              name
            }
          }
          species {
            __typename
            name
          }
        }
      }
    }
    """

  public let operationName: String = "StarWars"

  public var cursor: String?

  public init(cursor: String? = nil) {
    self.cursor = cursor
  }

  public var variables: GraphQLMap? {
    return ["cursor": cursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPeople", arguments: ["after": GraphQLVariable("cursor")], type: .object(AllPerson.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPeople: AllPerson? = nil) {
      self.init(unsafeResultMap: ["__typename": "Root", "allPeople": allPeople.flatMap { (value: AllPerson) -> ResultMap in value.resultMap }])
    }

    public var allPeople: AllPerson? {
      get {
        return (resultMap["allPeople"] as? ResultMap).flatMap { AllPerson(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "allPeople")
      }
    }

    public struct AllPerson: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PeopleConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          GraphQLField("people", type: .list(.object(Person.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(pageInfo: PageInfo, people: [Person?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "PeopleConnection", "pageInfo": pageInfo.resultMap, "people": people.flatMap { (value: [Person?]) -> [ResultMap?] in value.map { (value: Person?) -> ResultMap? in value.flatMap { (value: Person) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
        }
      }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var people: [Person?]? {
        get {
          return (resultMap["people"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Person?] in value.map { (value: ResultMap?) -> Person? in value.flatMap { (value: ResultMap) -> Person in Person(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Person?]) -> [ResultMap?] in value.map { (value: Person?) -> ResultMap? in value.flatMap { (value: Person) -> ResultMap in value.resultMap } } }, forKey: "people")
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PageInfo"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(hasNextPage: Bool) {
          self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return resultMap["hasNextPage"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasNextPage")
          }
        }
      }

      public struct Person: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Person"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("eyeColor", type: .scalar(String.self)),
            GraphQLField("hairColor", type: .scalar(String.self)),
            GraphQLField("skinColor", type: .scalar(String.self)),
            GraphQLField("birthYear", type: .scalar(String.self)),
            GraphQLField("vehicleConnection", type: .object(VehicleConnection.selections)),
            GraphQLField("species", type: .object(Species.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, eyeColor: String? = nil, hairColor: String? = nil, skinColor: String? = nil, birthYear: String? = nil, vehicleConnection: VehicleConnection? = nil, species: Species? = nil) {
          self.init(unsafeResultMap: ["__typename": "Person", "name": name, "eyeColor": eyeColor, "hairColor": hairColor, "skinColor": skinColor, "birthYear": birthYear, "vehicleConnection": vehicleConnection.flatMap { (value: VehicleConnection) -> ResultMap in value.resultMap }, "species": species.flatMap { (value: Species) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The name of this person.
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// The eye color of this person. Will be "unknown" if not known or "n/a" if the
        /// person does not have an eye.
        public var eyeColor: String? {
          get {
            return resultMap["eyeColor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "eyeColor")
          }
        }

        /// The hair color of this person. Will be "unknown" if not known or "n/a" if the
        /// person does not have hair.
        public var hairColor: String? {
          get {
            return resultMap["hairColor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "hairColor")
          }
        }

        /// The skin color of this person.
        public var skinColor: String? {
          get {
            return resultMap["skinColor"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "skinColor")
          }
        }

        /// The birth year of the person, using the in-universe standard of BBY or ABY -
        /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is
        /// a battle that occurs at the end of Star Wars episode IV: A New Hope.
        public var birthYear: String? {
          get {
            return resultMap["birthYear"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "birthYear")
          }
        }

        public var vehicleConnection: VehicleConnection? {
          get {
            return (resultMap["vehicleConnection"] as? ResultMap).flatMap { VehicleConnection(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "vehicleConnection")
          }
        }

        /// The species that this person belongs to, or null if unknown.
        public var species: Species? {
          get {
            return (resultMap["species"] as? ResultMap).flatMap { Species(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "species")
          }
        }

        public struct VehicleConnection: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PersonVehiclesConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("vehicles", type: .list(.object(Vehicle.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(vehicles: [Vehicle?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "PersonVehiclesConnection", "vehicles": vehicles.flatMap { (value: [Vehicle?]) -> [ResultMap?] in value.map { (value: Vehicle?) -> ResultMap? in value.flatMap { (value: Vehicle) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of all of the objects returned in the connection. This is a convenience
          /// field provided for quickly exploring the API; rather than querying for
          /// "{ edges { node } }" when no edge data is needed, this field can be be used
          /// instead. Note that when clients like Relay need to fetch the "cursor" field on
          /// the edge to enable efficient pagination, this shortcut cannot be used, and the
          /// full "{ edges { node } }" version should be used instead.
          public var vehicles: [Vehicle?]? {
            get {
              return (resultMap["vehicles"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Vehicle?] in value.map { (value: ResultMap?) -> Vehicle? in value.flatMap { (value: ResultMap) -> Vehicle in Vehicle(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Vehicle?]) -> [ResultMap?] in value.map { (value: Vehicle?) -> ResultMap? in value.flatMap { (value: Vehicle) -> ResultMap in value.resultMap } } }, forKey: "vehicles")
            }
          }

          public struct Vehicle: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Vehicle"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("name", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Vehicle", "id": id, "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The ID of an object
            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            /// The name of this vehicle. The common name, such as "Sand Crawler" or "Speeder
            /// bike".
            public var name: String? {
              get {
                return resultMap["name"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }
          }
        }

        public struct Species: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Species"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Species", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The name of this species.
          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}
