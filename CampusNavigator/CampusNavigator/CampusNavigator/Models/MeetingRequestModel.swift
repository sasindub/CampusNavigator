import Foundation
enum RequestStatus: String, CaseIterable {
    case pending = "Pending"
    case approved = "Approved"
    case rejected = "Rejected"
    case rescheduled = "Rescheduled"
}

struct MeetingRequest: Identifiable {
    let id = UUID()
    var date: Date
    var lecturer: String
    var subject: String
    var reason: String
    var status: RequestStatus
}
