//
//  PeopleDetailView.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 8/11/20.
//

import SwiftUI

struct PersonDetailView: View {
    let person: Person

    var body: some View {
        ScrollView {
            Spacer(minLength: 32)
            VStack(alignment: .leading) {
                SectionTitle(title: "General Information")

                InformationView(title: "Eye Color",
                                value: person.eyeColor?.capitalized ?? "-")
                    Divider()
                        .padding(.leading, 15)

                InformationView(title: "Hair Color",
                                value: person.hairColor?.capitalized ?? "-")
                    Divider()
                        .padding(.leading, 15)

                InformationView(title: "Skin Color",
                                value: person.skinColor?.capitalized  ?? "-")
                    Divider()
                        .padding(.leading, 15)

                InformationView(title: "Birth Year",
                                value: person.birthYear  ?? "-")
                    Divider()
                        .padding(.leading, 15)
            }

            Spacer(minLength: 8)
            if let vehicles = person.vehicleConnection?.vehicles, !vehicles.isEmpty {
                Spacer(minLength: 32)
                SectionTitle(title: "Vehicles")
                
                ForEach(vehicles.compactMap { $0 }, id: \.id) { vehicle in
                    VehicleView(name: vehicle.name ?? "")
                }
            }
        }.navigationBarTitle(person.name ?? "", displayMode: .inline)
    }
}

struct PeopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let person = Person(id: "1",
                            name: "Luke Skywalker",
                            eyeColor: "Blue",
                            hairColor: "Blond",
                            skinColor: "Fair",
                            birthYear: "19BBY",
                            vehicleConnection: .init(
                                vehicles:[
                                    .init(id: "1",
                                          name: "Snowspeeder"),
                                    .init(id: "3",
                                          name: "Imperial Speeder Bike"),
                                ]
                            )
                        )
       return PersonDetailView(person: person)
    }
}

struct InformationView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Color(Colors.lightText))
                    .font(.system(size: 17, weight: .bold))
                Spacer()
                Text(value)
                    .foregroundColor(Color(Colors.darkText))
                    .font(.system(size: 17, weight: .bold))
            }
        }.padding(.top, 13)
        .padding([.leading, .trailing], 15)
    }
}

struct SectionTitle: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(Colors.darkText))
                .font(.system(size: 17, weight: .bold))
            Spacer()
        }.padding(.leading, 15)
    }
}

struct VehicleView: View {
    let name: String

    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .foregroundColor(Color(Colors.lightText))
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }.padding(.leading, 15)
            .padding(.top, 13)
            Divider()
                .padding(.leading, 15)
        }
    }
}
