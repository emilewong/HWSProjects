//
//  EmojiRatingView.swift
//  HWSProjects
//
//  Created by Emile Wong on 9/6/2021.
//

import SwiftUI

struct EmojiRatingView: View {
    // MARK: - PROPERTIES
    let rating: Int16
    
    // MARK: - BODY
    var body: some View {
        switch rating {
            case 1:
                return Text("đĢ")
            case 2:
                return Text("âšī¸")
            case 3:
                return Text("đ")
            case 4:
                return Text("đ")
            default:
                return Text("đ¤Š")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
