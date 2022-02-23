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

    @State var snake = Snake(gridHeight: 10, gridWidth: 10)
    @State var direction = Direction.East
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            GridView(height: 10, width: 10)
            ControlView(direction: $direction)
        }.onAppear() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
                snake.Move(direction: direction)
             })
        }
        .environmentObject(snake)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
