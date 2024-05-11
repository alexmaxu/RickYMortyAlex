//
//  CharacterCell.swift
//  RickYMortyAlex
//
//  Created by Alex  on 3/5/24.
//

import SwiftUI

struct CharacterCell: View {
    let character: RyMCharacterDTO
    var body: some View {
        HStack {
            VStack {
                Text(character.name)
                Text("id: \(character.id)")
            }
            Spacer()
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(width: 80)
                    .padding()
            } placeholder: {
                ProgressView()
            }
            
        }
    }
}

#Preview {
    CharacterCell(character: .previewCharacter)
}
