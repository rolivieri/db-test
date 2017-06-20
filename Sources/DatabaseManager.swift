import CouchDB
import LoggerAPI
import Foundation

class DatabaseManager {

  private var db: Database? = nil
  private let dbClient: CouchDBClient
  private let dbName: String

  init() {
    self.dbName = "mydb"
    let connectionProperties = ConnectionProperties(host: "<host>",
    port: Int16(443),
    secured: true,
    username: "<username>",
    password: "<password>")
    self.dbClient = CouchDBClient(connectionProperties: connectionProperties)
  }

  public func getDatabase(callback: @escaping (Database?, NSError?) -> ()) -> Void {
    if let database = db {
      callback(database, nil)
      return
    }

    dbClient.dbExists(dbName) { (exists: Bool, error: NSError?) in
      if let error = error {
        Log.error("Crap... something went wrong: \(error)")
        callback(self.db, error)
      } else {
        if exists {
          Log.info("Database '\(self.dbName)' found.")
          self.db = self.dbClient.database(self.dbName)
          callback(self.db, error)
        } else {
          self.dbClient.createDB(self.dbName) { (db: Database?, error: NSError?) in
            if let error = error {
              Log.error("Something went wrong: \(error)")
            } else {
              Log.info("Database '\(self.dbName)' created.")
            }
            self.db = db
            callback(self.db, error)
          }
        }
      }
    }
  }
}
