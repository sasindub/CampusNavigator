import Foundation
struct ComplaintSuggestion: Identifiable {
    let id = UUID()
    var subject: String
    var details: String
    var date: Date
    var isSuggestion: Bool
}
