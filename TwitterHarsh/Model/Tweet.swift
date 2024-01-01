//
//  Tweet.swift
//  TwitterHarsh
//
//  Created by My Mac Mini on 28/12/23.
//

import Foundation

struct Tweet: Codable, Identifiable {
    var id = UUID().uuidString
    let author: TwitterUser
    let authorID: String
    let tweetContent: String
    var likesCount: Int
    var likers: [String]
    let isReply: Bool
    let parentReference: String?
    var createdOn: Date = Date()
}
