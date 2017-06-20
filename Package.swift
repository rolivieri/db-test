// swift-tools-version:3.1

import PackageDescription

let package = Package(
  name: "db-test",
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1),
    .Package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git", majorVersion: 1)
  ]
)
