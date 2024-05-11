//
//  CustomAlertView.swift
//  RickYMortyAlex
//
//  Created by Alex  on 9/5/24.
//

import SwiftUI

struct CustomAlertView: View {
    let alertDescription: String
    let alertTitle: String
    let buttonText: String
    
    let alertAction: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundStyle(.red)
            
            Text(alertTitle)
                .font(.largeTitle)
                .bold()
            Text(alertDescription)
            HStack {
                Button {
                    alertAction()
                } label: {
                    Text(buttonText)
                        .bold()
                }
            }
                
        }
        .padding()
        .background {
            Color.gray.opacity(0.2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    CustomAlertView(alertDescription: "Something is going wrong!", alertTitle: "Caution!", buttonText: "Button", alertAction: {
        print("hola")
    } )
}
