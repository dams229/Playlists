//
//  Track.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import Foundation

struct Track {

    // MARK: - Properties
    
    let title: String
    let artist: Artist
    let duration: TimeInterval
    
    
    // MARK: - Initializers
    
    init?(json: [String: Any]?) {
        guard let json = json else {
            return nil
        }
        self.title = json["title"] as! String
        self.artist = Artist(json: json["artist"] as? [String: AnyObject])!
        self.duration = json["duration"] as! TimeInterval
    }
    
    static func tracks(fromJson json: [[String: Any]]?) -> [Track]? {
        guard let json = json else {
            return nil
        }
        
        return json.map({ Track(json: $0)! })
    }
    
}
