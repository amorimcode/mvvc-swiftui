//
//  ContentView.swift
//  mvvm
//
//  Created by Bruno Amorim on 02/10/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var model: ContentViewModel
        
    init(model: ContentViewModel) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            Text(model.state.isLoading ? "Carregando..." : model.state.message)
                .onAppear(perform: model.loadData)
        }
        .padding()
    }
}

struct ContentViewState {
      var isLoading = false
      var message = ""
}

class ContentViewModel: ObservableObject {
    private(set) var state: ContentViewState
    
    
    init(initialState: ContentViewState = .init()) {
        state = initialState
    }
    
    func loadData() {
        state.isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.state.isLoading = false
            self.state.message = "Olá mundo"
        }
    }
}

#Preview {
    ContentView(model: .init())
}
