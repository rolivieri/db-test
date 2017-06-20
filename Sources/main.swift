import LoggerAPI
import HeliumLogger
import Foundation
import LoggerAPI
import CouchDB

// Init logger
HeliumLogger.use(LoggerMessageType.verbose)

let dbMgr = DatabaseManager()
dbMgr.getDatabase() { (db: Database?, error: NSError?) in
  guard let db = db else {
    Log.error(">> No database.")
    return
  }

  db.retrieveAll(includeDocuments: true) { docs, error in
    guard let docs = docs else {
      Log.error(">> Could not read from database or none exists.")
      return
    }

    Log.info(">> Successfully retrived all docs from db.")
    Log.info("docs: \(docs)")
  }
}
