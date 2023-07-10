//
//  StatView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 10/7/23.
//

import SwiftUI

struct StatView: View {
    
    @Binding var isNewGameShown: Bool
    
    var body: some View {
        NavigationStack {
            Text("todo: stat view")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            isNewGameShown = true
                        } label: {
                            Label("New game", systemImage: "goforward.plus")
                        }
                    }
                }
        }
    }
}
