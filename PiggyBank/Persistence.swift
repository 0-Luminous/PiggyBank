//
//  Persistence.swift
//  PiggyBank
//
//  Created by Yan on 7/3/25.
//

import CoreData

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Здесь можно добавить тестовые данные для превью
        return result
    }()

    let container: NSPersistentContainer
    @Published var viewContext: NSManagedObjectContext
    private var saveObserver: NSObjectProtocol?

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PiggyBank")
        viewContext = container.viewContext

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }

        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.automaticallyMergesChangesFromParent = true

        // Настройка автоматического сохранения
        setupAutoSaving()
    }

    private func setupAutoSaving() {
        saveObserver = NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextObjectsDidChange,
            object: viewContext,
            queue: .main
        ) { [weak self] _ in
            self?.save()
        }
    }

    deinit {
        if let observer = saveObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // Функция для сохранения контекста
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}
