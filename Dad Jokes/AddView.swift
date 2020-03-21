//
//  AddView.swift
//  Dad Jokes
//
//  Created by Ram Patra on 20/03/2020.
//  Copyright © 2020 Ram Patra. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var setup = ""
    @State private var punchline = ""
    @State private var rating = "Silence"
    private var ratings = ["Sob", "Sigh", "Silence", "Smirk"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Setup", text: $setup)
                    TextField("Punchline", text: $punchline)
                    
                    Picker("Rating", selection: $rating) {
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating)
                        }
                    }
                }
                
                Section {
                    Button("Add Joke") {
                        let newJoke = Joke(context: self.moc)
                        newJoke.setup = self.setup
                        newJoke.punchline = self.punchline
                        newJoke.rating = self.rating
                        
                        do {
                            try self.moc.save() // save joke
                            self.presentationMode.wrappedValue.dismiss() // dismiss screen/sheet after joke is added
                        } catch {
                            print("Error saving data to managed object contaxt \(error.localizedDescription)")
                        }
                    }
                }
            }
            .navigationBarTitle("New Joke")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
