//
//  CustomToolBar.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 3/12/24.
//

import SwiftUI

struct CustomToolBar: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        ForEach(CharacterStatus.allCases) { status in
                            Button(status.rawValue) {
                                
                            }
                        }
                        
                        
                    } label: {
                        //                        Image(systemName: "line.3.horizontal.decrease.circle")
                        Label("Status", systemImage:"line.3.horizontal.decrease.circle" )
                    }
                    
                }
            }
    }
}

extension View {
    func customToolBar() -> some View {
        modifier(CustomToolBar())
    }
}

