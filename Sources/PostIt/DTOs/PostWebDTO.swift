import Foundation

struct PostWebDTO: Encodable {
    let title: String
    let posts: [PostDTO]
}
