//
//  Artist.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import Foundation

struct Artist {
    
    // MARK: - Properties
    
    let name: String
    
    
    // MARK: - Initializers
    
    init?(json: [String: Any]?) {
        guard let json = json else {
            return nil
        }
        self.name = json["name"] as! String
    }
    
}

