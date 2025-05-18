import Fluent
import Vapor
import Leaf

struct PostController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let grouped = routes.grouped("posts")
        grouped.get("getAll", use: getAll)
        grouped.post("createPost", use: createPost)
        grouped.get("", use: indexTemplate)
        grouped.get("list", use: postsTemplate)
        grouped.get("create", use: createTemplate)
        grouped.post("create", use: createRedirect)
    }
    
    func getAll(req: Request) async throws -> [Posts] {
        try await Posts.query(on: req.db)
            .all()
    }
    
    func createPost(req: Request) async throws -> Response {
        let dto = try req.content.decode(PostDTO.self)
        let newPost = Posts(title: dto.title, description: dto.description)
        try await newPost.create(on: req.db)
        
        let response = Response(status: .created)
        try response.content.encode(["message": "Post created successfully"], as: .json)
        return response
    }
    
    func indexTemplate(req: Request) async throws -> View {
        return try await req.view.render("index-icon.leaf")
    }
    
    func postsTemplate(req: Request) async throws -> View {
        let query = try await Posts
            .query(on: req.db)
            .all()
            .map {
                PostDTO(id: $0.id, title: $0.title, description: $0.description)
            }
        let context = PostWebDTO(title: "Maestro de Posts", posts: query)
        return try await req.view.render("list.leaf", context)
    }
    
    func createTemplate(req: Request) async throws -> View {
        return try await req.view.render("create.leaf")
    }
    
    func createRedirect(req: Request) async throws -> Response {
        let post = try req.content.decode(PostDTO.self)
        let newPost = Posts(title: post.title, description: post.description)
        try await newPost.create(on: req.db)
        return req.redirect(to: "list")
    }
}
