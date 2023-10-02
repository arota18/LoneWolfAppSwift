//
//  StatView.swift
//  LoneWolfAppSwift
//
//  Created by Andrea Rota on 10/7/23.
//

import SwiftUI

struct StatMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 50)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.secondary, lineWidth: 4)
            }
    }
}

extension View {
    func statMod() -> some View {
        modifier(StatMod())
    }
}

enum Orientation {
    case horizontal, vertical
}

struct StatView: View {
    
    @EnvironmentObject var player: Player
    @Binding var isNewGameShown: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SingleStatView(statName: "Combat skill", singleStat: $player.combat)
                    .padding(.bottom)
                SingleStatView(statName: "Endurance", singleStat: $player.endurance)
            }
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

struct SingleStatView: View {
    
    @Binding var singleStat: Int
    let statName: String
    let orientation: Orientation
    let iconSizeAndGap = 32.0 // TODO: think about make it editable
    
    init(statName: String, singleStat: Binding<Int>) {
        self.statName = statName
        self._singleStat = singleStat
        self.orientation = .horizontal
    }
    
    init(statName: String, singleStat: Binding<Int>, orientation: Orientation) {
        self.statName = statName
        self._singleStat = singleStat
        self.orientation = orientation
    }
    
    var body: some View {
        VStack {
            Text(statName)
                .foregroundColor(.secondary)
            HStack(spacing: iconSizeAndGap) {
                Button(role: .destructive) {
                    singleStat -= 1
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSizeAndGap)
                }
                Text("\(singleStat)")
                    .statMod()
                    .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                             // TODO: think about add onChange modifier
                        .onEnded({ value in
                            if orientation == .horizontal {
                                if value.translation.width > 0 {
                                    singleStat += 1
                                } else if value.translation.width < 0 {
                                    singleStat -= 1
                                }
                            } else {
                                if value.translation.height < 0 {
                                    singleStat += 1
                                } else if value.translation.height > 0 {
                                    singleStat -= 1
                                }
                            }
                        })
                    )
                Button {
                    singleStat += 1
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: iconSizeAndGap)
                }
            }
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper(false) { val in
            StatView(isNewGameShown: val)
                .environmentObject(Player.example)
        }
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    var body: some View {
        content($value)
    }
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
