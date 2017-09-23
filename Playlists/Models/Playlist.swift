//
//  Playlist.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit

class Playlist: NSObject {

    // MARK: - Properties
    
    let id: Int
    let title: String
    let creatorName: String
    let duration: TimeInterval
    
    let mediumPictureUrl: URL?
    // Keep some reference to the medium picture image and average color to avoid computing it again
    var mediumPicture: UIImage?
    var mediumPictureAverageColor: UIColor?
    let xlPictureUrl: URL?
    
    
    // MARK: - Initializers
    
    init?(json: [String: Any]?) {
        guard let json = json else {
            return nil
        }
        self.id = json["id"] as! Int
        self.title = json["title"] as! String
        self.creatorName = (json["creator"] as? [String: AnyObject])?["name"] as? String ?? ""
        self.duration = json["duration"] as! TimeInterval
        
        self.mediumPictureUrl = URL(string: json["picture_medium"] as? String ?? "")
        self.xlPictureUrl = URL(string: json["picture_xl"] as? String ?? "")
    }
    
    static func playlists(fromJson json: [[String: Any]]?) -> [Playlist]? {
        guard let json = json else {
            return nil
        }
        
        return json.map({ Playlist(json: $0)! })
    }
    
}
