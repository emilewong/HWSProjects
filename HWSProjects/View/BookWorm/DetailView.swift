//
//  DetailView.swift
//  HWSProjects
//
//  Created by Emile Wong on 9/6/2021.
//

import CoreData
import SwiftUI

struct DetailView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
        
    // MARK: - FUNCTIONS
    func deleteBook(){
        moc.delete(book)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    
    
    let book: Book
    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack(alignment: .bottomTrailing){
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "Fantasy".uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                } //: ZSTACK
                Text(self.book.author ?? "Unknow author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(self.book.review ?? "No review")
                    .padding()
                RatingView(rating: .constant(Int(self.book.rating)))
                
                Spacer()
            } //: VSTACK
        } //: READER
        .navigationBarTitle(Text(book.title ?? "Unknow Title"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")){self.deleteBook()},
                  secondaryButton: .cancel())
        })
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }, label: {
            Image(systemName: "trash")
        }))
    }
}
// MARK: - PREVIEW
struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test title"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "Test review, this is a great book"
        
        return NavigationView{
            DetailView(book: book)
        }
    }
}
