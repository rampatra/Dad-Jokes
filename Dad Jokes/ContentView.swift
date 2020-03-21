//
//  ContentView.swift
//  Dad Jokes
//
//  Created by Ram Patra on 20/03/2020.
//  Copyright © 2020 Ram Patra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    let jokes = [
//        Joke(setup: "What's a cow's favorite place?", punchline: "A mooseum", rating: "Silence"),
//        Joke(setup: "What's brown and sticky?", punchline: "A stick", rating: "Sigh"),
//        Joke(setup: "What's orange and sounds like a parrot?", punchline: "A Carrot", rating: "Smirk")
//    ]
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Joke.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Joke.setup, ascending: true)]) var jokes: FetchedResults<Joke>
    
    @State private var showingAddJokeView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(jokes, id: \.setup) { joke in
                    NavigationLink(destination: Text(joke.punchline)) {
                        EmojiView(for: joke.rating)
                        Text(joke.setup)
                    }
                }
                .onDelete(perform: deleteJokes)
            }
            .navigationBarTitle("All Groan up")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                self.showingAddJokeView.toggle()
            })
            .sheet(isPresented: $showingAddJokeView) {
                AddView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteJokes(at offsets: IndexSet) {
        for index in offsets {
            let joke = jokes[index]
            moc.delete(joke)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
