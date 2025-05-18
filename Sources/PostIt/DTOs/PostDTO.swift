import Fluent
import Vapor

struct PostDTO: Content {
    var id: UUID?
    var title: String
    var description: String
}

extension PostDTO {
    var toDto: PostDTO {
        PostDTO(id: id, title: title, description: description)
    }
}
