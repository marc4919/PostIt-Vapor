import NIOSSL
import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public func configure(_ app: Application) async throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    if let databaseURL = Environment.get("DATABASE_URL") {
        try app.databases.use(.postgres(url: databaseURL), as: .psql)
        app.logger.info("Conexión a la base de datos establecida correctamente")
    } else {
        app.logger.critical("DATABASE_URL no está configurada o es inválida")
        throw Abort(.internalServerError, reason: "No se pudo configurar la base de datos")
    }

    app.migrations.add(PostsMigration())

    try await app.autoMigrate()

    app.views.use(.leaf)
    app.leaf.configuration.rootDirectory = "Resources/Views"

    try routes(app)
}
