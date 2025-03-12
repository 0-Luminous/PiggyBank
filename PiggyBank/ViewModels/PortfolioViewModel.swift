import CoreData
import Foundation
import SwiftUI

class PortfolioViewModel: ObservableObject {
    @Published var totalValue: Double = 0
    private var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.viewContext) {
        self.viewContext = context
        calculateTotalValue()
    }

    func calculateTotalValue() {
        let fetchRequest: NSFetchRequest<StockEntity> = StockEntity.fetchRequest()

        do {
            let stocks = try viewContext.fetch(fetchRequest)
            totalValue = stocks.reduce(0.0) { $0 + ($1.price * Double($1.quantity)) }
        } catch {
            print("Error fetching stocks: \(error)")
        }
    }

    func updateStock(_ stock: StockEntity, quantity: Int) {
        stock.quantity = Int16(quantity)
        save()
        calculateTotalValue()
    }

    private func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
