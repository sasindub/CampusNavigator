import Foundation


struct Event: Identifiable {
    let id = UUID()
    var title: String
    var image: String
    var members: String
    var spotsLeft: String
    var date: String
    var time: String
    var host: String
    var price: String
}
