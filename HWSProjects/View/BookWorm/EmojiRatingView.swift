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
                return Text("😫")
            case 2:
                return Text("☹️")
            case 3:
                return Text("😐")
            case 4:
                return Text("😏")
            default:
                return Text("🤩")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
