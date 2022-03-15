//
//  ContentView.swift
//  Shared
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State var direction = Direction.East
    @State var timer: Timer?
    @State var snakeReinforcementlearning: SnakeReinforcementLearning?
    @StateObject var configuration =  Configuration()
    @State var tryingItOut: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $tryingItOut, destination: { ModelView(snakeReinforcementlearning: $snakeReinforcementlearning) }, label: { EmptyView() })
                ConfigurationView(configuration: self.configuration)
                Button("Try it out!") {
                    snakeReinforcementlearning = SnakeReinforcementLearning(configuration: configuration)
                    tryingItOut = true
                }
            }
            
        }
    }
    
    init() {
        //snakeReinforcementlearning.Learn()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
