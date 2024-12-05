//
//  CustomErrorView.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 5/12/24.
//

import SwiftUI

struct CustomErrorView: View {
    let errorTitle: String
    let errorMessage: String
    let retryAction: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 70))
                .foregroundColor(.red)
                .rotationEffect(.degrees(isAnimating ? 10 : -10))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
            Text(errorTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                retryAction()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Try again")
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top)
        }
        .padding()
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    CustomErrorView(
        errorTitle: "Alberto",
        errorMessage: "Error Alberto") {
            //
        }
}


