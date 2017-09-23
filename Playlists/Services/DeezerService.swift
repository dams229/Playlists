//
//  DeezerService.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import Alamofire

/// Deezer API interface class
class DeezerService: NSObject, MusicService {
    
    // MARK: - Constants
    
    /// Deezer API URL
    static private let apiUrl = "https://api.deezer.com"
    
    
    // MARK: - MusicService methods
    
    /// Fetch a user playlists
    static func userPlaylists(userId: String, completion: @escaping (_ playlists: [Playlist])->Void) {
        toggleActivityIndicator(show: true)
        request(apiUrl + "/user/\(userId)/playlists").responseJSON { (response) in
            toggleActivityIndicator(show: false)
            var playlists: [Playlist]?
            if let json = response.result.value as? [String: AnyObject], let data = json["data"] as? [[String: AnyObject]] {
                playlists = Playlist.playlists(fromJson: data)
            }
            completion(playlists ?? [Playlist]())
        }
    }
    
    /// Fetch a playlist tracks. Returns tracks and next url if any
    static func playlistTracks(playlistId: Int, nextUrl: String? = nil, completion: @escaping (_ tracks: [Track], _ nextUrl: String?)->Void) {
        toggleActivityIndicator(show: true)
        let requestUrl = nextUrl ?? apiUrl + "/playlist/\(playlistId)/tracks"
        request(requestUrl).responseJSON { (response) in
            toggleActivityIndicator(show: false)
            if let json = response.result.value as? [String: AnyObject], let data = json["data"] as? [[String: AnyObject]] {
                // Get tracks list
                let tracks = Track.tracks(fromJson: data)
                // Url to load next tracks
                let nextUrl = json["next"] as? String
                completion(tracks ?? [Track](), nextUrl)
            }
        }
    }
    
    
    // MARK: - Utility methods
    
    private static func toggleActivityIndicator(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }

}
