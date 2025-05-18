import Vapor
import Fluent
import struct Foundation.UUID

final class Posts: Model, Content, @unchecked Sendable {
    static let schema = "posts"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    init() { }

    init(id: UUID? = nil, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
