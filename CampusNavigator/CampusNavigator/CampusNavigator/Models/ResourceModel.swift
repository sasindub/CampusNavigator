import Foundation


struct ResourceItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    var status: ResourceStatus
    let accuracy: Double
}

enum ResourceStatus: String, CaseIterable {
    case available = "Available"
    case crowded = "Crowded"
    case moderate = "Moderate Crowded"
    case closed = "Closed"
}
