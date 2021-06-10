//
//  AddBookView.swift
//  HWSProjects
//
//  Created by Emile Wong on 9/6/2021.
//

import SwiftUI
import CoreData

struct AddBookView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var date = Date()
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title of book: ", text: $title)
                    TextField("Author's name: ", text: $author)
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    DatePicker("Please enter a Date", selection: $date)
                        .labelsHidden()
                } //: SECTION
                
                Section{
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                } //: SECTION
                
                Section{
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.genre = self.genre == "" ? "Fantasy" : self.genre
                        newBook.rating = Int16(self.rating)
                        newBook.review = self.review
                        newBook.date = self.date
                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                } //: SECTION
            } //: FORM
            .navigationBarTitle("Add Book")
        } //: NAVIGATION
    }
}
// MARK: - PREVIEW
struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
