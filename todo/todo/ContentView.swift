//
//  ContentView.swift
//  todo
//
//  Created by Navami Ajay on 31/10/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.self) private var env
    @StateObject private var viewmodel = todoViewModel()
    
    func deleteTask(at offset: IndexSet) {
        offset.forEach { index in
            let task = viewmodel.tasks[index] // task to delete
            viewmodel.delete(_task: task)
        }
        viewmodel.getAllTasks()
    }
    
    
    var body: some View {
        VStack {
            TextField("enter task name", text: $viewmodel.title)
                .textFieldStyle(.roundedBorder)
            Button("SAVE"){
                viewmodel.save()
                viewmodel.getAllTasks()
            }
            
            //            List(viewmodel.tasks, id: \.id){ task in
            //                Text(task.title)
            //            }
            
            List{
                ForEach(viewmodel.tasks, id:\.id){ task in
                    Text(task.title)
                }
                
                .onDelete(perform: deleteTask)
                //viewmodel.save()
            }.listStyle(.plain)
            
            
            
            Spacer()
            
        } .padding()
        
            .onAppear(perform: {  // to see the items when the page loads itself, otherwise it will display only after the button is clicked
                viewmodel.getAllTasks()
            })
    }
    
}

#Preview {
    ContentView()
}
