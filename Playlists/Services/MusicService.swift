//
//  MusicService.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import Foundation

/// This protocols define the functions a music service should implement
protocol MusicService {
    static func userPlaylists(userId: String, completion: @escaping (_ playlists: [Playlist])->Void)
    static func playlistTracks(playlistId: Int, nextUrl: String?, completion: @escaping (_ tracks: [Track], _ nextUrl: String?)->Void)
}
