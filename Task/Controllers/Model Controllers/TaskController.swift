//
//  TaskController.swift
//  Task
//
//  Created by Timothy Rosenvall on 6/19/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedInstance = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let descriptIsComplete: NSSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let descriptDue: NSSortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        let descriptors = [descriptIsComplete, descriptDue]
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = descriptors
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
    
    // CRUD Functions
    // Create
    func createTask (name: String, notes: String?, due: Date?) {
        Task(name: name, notes: notes, due: due, context: CoreDataStack.context)
        saveToPersistentStore()
    }
    
    // Read
    func saveToPersistentStore () {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error Saving: \(error.localizedDescription)")
        }
    }
    
    // Update
    func updateTask (task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.due = due
        task.notes = notes
        saveToPersistentStore()
    }
    
    // Delete
    func deleteTask (task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
        }
    }
    
    func toggleIsCompleteFor (task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
}
