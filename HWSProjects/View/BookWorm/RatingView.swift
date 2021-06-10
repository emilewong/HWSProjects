//
//  RatingView.swift
//  HWSProjects
//
//  Created by Emile Wong on 9/6/2021.
//

import SwiftUI

struct RatingView: View {
    // MARK: - PROPERTIES
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    // MARK: - FUNCTIONS
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    // MARK: - BODY
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach( 1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        } //: HSTACK
    }
}
// MARK: - PREVIEW
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
