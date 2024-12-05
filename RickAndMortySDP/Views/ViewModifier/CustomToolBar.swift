//
//  CustomToolBar.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 3/12/24.
//

import SwiftUI

struct CustomToolBar: ViewModifier {
    
    @Binding var charStatus: CharacterStatus
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        ForEach(CharacterStatus.allCases) { status in
                            Button {
                                charStatus = status
                            } label: {
                                LabeledContent(status.rawValue) {
                                    Image(systemName: charStatus == status ? "checkmark.circle.fill" : "checkmark.circle")
                                }
                            }
                        }
                    } label: {
                        Label("Status", systemImage:"line.3.horizontal.decrease.circle" )
                    }
                    
                }
            }
    }
}

extension View {
    func customToolBar(charStatus: Binding<CharacterStatus>) -> some View {
        modifier(CustomToolBar(charStatus: charStatus))
    }
}

