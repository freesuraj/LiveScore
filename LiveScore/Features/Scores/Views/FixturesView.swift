//
//  FixturesView.swift
//  LiveScore
//
//  Created by Suraj Pathak on 7/2/2025.
//

import SwiftUI

struct FixturesView: View {
    
    @State private var viewModel = FixtureViewModel()
    @State private var searchTerm: String = ""
    @State private var selectedFixtureID: Int?
    @State private var loadingError: Error?
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            if let errorMessage = loadingError?.localizedDescription {
                ErrorView(message: errorMessage) {
                    loadingError = nil
                    Task {
                        await fetchData()
                    }
                }
            } else if viewModel.isLoading {
                LoadingView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.fixtures.filteredBy(searchTerm)) { fixture in
                            NavigationLink {
                                MatchDetailView(fixture)
                            } label: {
                                ScoreCardView(fixture: fixture,
                                              selected: Binding(get: {
                                    selectedFixtureID == fixture.id
                                }, set: { _ in
                                    
                                }))
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                withAnimation {
                                    selectedFixtureID = fixture.id
                                }
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.gray.opacity(0.2))
                .navigationTitle("Fixtures")
                .searchable(text: $searchTerm, prompt: "Search team name")
                .refreshable {
                    await fetchData()
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchScores()
        } catch {
            loadingError = error
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            Task { await fetchData() }
        }
        
        // First time, start fetching
        Task { await fetchData() }
        
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview {
    FixturesView()
}
