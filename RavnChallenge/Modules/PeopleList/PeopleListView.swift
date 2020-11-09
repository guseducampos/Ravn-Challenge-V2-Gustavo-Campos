//
//  PeopleListView.swift
//  RavnChallenge
//
//  Created by Gustavo Campos on 8/11/20.
//

import SwiftUI

struct PeopleListView: View {
    @ObservedObject var viewModel: PeopleListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.state.response.people,
                            id: \.id) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            VStack {
                                PeopleView(person: person)
                                    .onAppear {
                                        viewModel.loadMoreContent(after: person)
                                    }
                                Divider()
                                    .padding(.leading, 16)
                            }
                        }
                    }
                }
                FailedView(failed: $viewModel.state.requestFailed)
                LoadingView(isLoading: $viewModel.state.isLoading)
            }.navigationBarTitle("People", displayMode: .inline)
            .modifier(
                NavigationBarModifier(
                        titleColor: .white,
                        backgroundColor: UIColor(named: Colors.ravnBlack) ?? .black)
            )
            .onAppear {
                viewModel.fetchPeople()
            }
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PeopleListView(
                viewModel: .init(starWarsClient: .happyPath)
            )

            PeopleListView(
                viewModel: .init(starWarsClient: .failedClient)
            )
        }
    }
}

struct PeopleView: View {
    let person: Person

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name ?? "")
                    .foregroundColor(Color(Colors.darkText))
                    .font(.system(size: 17, weight: .bold, design: .default))

                Text(person.origin)
                    .foregroundColor(Color(Colors.lightText))
                    .font(.system(size: 14))
            }

            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 7)
                .foregroundColor(Color(Colors.darkText))
        }.padding([.top, .trailing, .leading], 16)
    }
}

struct FailedView: View {
    @Binding var failed: Bool

    var body: some View {
        if failed {
            Text("Failed to Load Data")
                .foregroundColor(Color(Colors.emphasisText))
                .font(.system(size: 17, weight: .bold))
        }
    }
}

struct LoadingView: View {
    @Binding var isLoading: Bool

    var body: some View {
        if isLoading {
            HStack(spacing: 10) {
                ProgressView()
                Text("Loading")
                    .foregroundColor(Color(Colors.lightText))
                    .font(.system(size: 17, weight: .bold))
            }
        }
    }
}
