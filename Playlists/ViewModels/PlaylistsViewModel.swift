//
//  PlaylistsViewModel.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import RxSwift

/// Playlists view model
class PlaylistsViewModel: NSObject {

    // MARK: - Properties
    
    /// The user's playlists
    let playlists = Variable<[Playlist]>([])
    
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        DeezerService.userPlaylists(userId: Constants.deezerUserId) { (playlists) in
            self.playlists.value.append(contentsOf: playlists)
        }
    }
    
}
