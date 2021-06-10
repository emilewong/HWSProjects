//
//  BookWormView.swift
//  HWSProjects
//
//  Created by Emile Wong on 6/6/2021.
//

import SwiftUI
import CoreData

struct BookWormView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    // MARK: - FUNCTIONS
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            
            moc.delete(book)
        }
        try? moc.save()
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            List{
                ForEach(books, id: \.self){ book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                        
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknow Title")
                                .font(.headline)
                                .foregroundColor(book.rating < 2 ? Color.red : Color.white)
                            Text(book.author ?? "Unknow Author")
                                .foregroundColor(.secondary)
                        } //: VSTACK
                    } //: LINK
                } //: LOOP
                .onDelete(perform: deleteBooks)
            } //: LIST
            .navigationBarTitle("Bookwork")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingAddScreen.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showingAddScreen, content: {
                AddBookView().environment(\.managedObjectContext, self.moc)
            })
        }
    }
}
// MARK: - PREVIEW
struct BookWormView_Previews: PreviewProvider {
    static var previews: some View {
        BookWormView()
    }
}
