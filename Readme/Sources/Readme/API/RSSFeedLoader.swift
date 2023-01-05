//
//  File.swift
//  
//
//  Created by Pol Piella Abadia on 23/07/2021.
//

import FeedKit
import Foundation

struct RSSFeedLoader {
    let parser: FeedParser
    
    init(parser: FeedParser = .init(URL: URL(string: "https://posts.boy.sh/feed.xml")!)) {
        self.parser = parser
    }
}

extension RSSFeedLoader: PostFeedLoader {
    func load() throws ->  [Post] {
        try parser
            .parse()
            .get()
            .atomFeed?
            .entries?
            .compactMap { $0 }
            .prefix(3)
            .map { Post(title: $0.title ?? "", link: $0.links?.first?.attributes?.href ?? "") } ?? []
    }
}
