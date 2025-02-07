//
//  ContentView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 7/2/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scores: [LiveScore] = []
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            List(scores.filteredBy(searchTerm)) { score in
                NavigationLink {
                    DetailView(score: score)
                } label: {
                    HStack {
                        Text(score.teamOne)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        
                        Text(score.result)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(.gray)
                            }
                            .layoutPriority(2)
                        
                        Text(score.teamTwo)
                            .multilineTextAlignment(.trailing)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .layoutPriority(1)
                    }
                }

            }
            .navigationTitle("Scoreboard")
            .searchable(text: $searchTerm, prompt: "Search team name")
            .task {
                scores = await fetchScores()
            }
        }
        
    }
    
    func fetchScores() async -> [LiveScore] {
        [.init(id: "1", teamOne: "Arsenal", teamTwo: "Man City", result: "0:0"),
         .init(id: "2", teamOne: "Man City", teamTwo: "Man United", result: "2:0"),
         .init(id: "3", teamOne: "Arsenal", teamTwo: "Liverpool", result: "0:1")]
    }
}

#Preview {
    ContentView()
}

struct LiveScore: Hashable, Identifiable {
    var id: String
    var teamOne: String
    var teamTwo: String
    var result: String
}

extension [LiveScore] {
    
    func filteredBy(_ searchText: String) -> [LiveScore] {
        guard !searchText.isEmpty else { return self }
        return self.filter { $0.teamOne.contains(searchText) || $0.teamTwo.contains(searchText) }
    }
}


struct DetailView: View {
    let score: LiveScore
    
    var body: some View {
        VStack {
            Text(score.teamOne)
            Text(score.result)
            Text(score.teamTwo)
        }
    }
}
