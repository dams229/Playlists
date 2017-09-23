//
//  PlaylistDetailsViewModel.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import RxSwift

class PlaylistDetailsViewModel: NSObject {

    // MARK: - Properties
    
    let playlist: Playlist
    
    let playlistName = BehaviorSubject<String>(value: "")
    let playlistAuthor = BehaviorSubject<String>(value: "")
    let playlistDuration = BehaviorSubject<String>(value: "")
    let playlistCover = BehaviorSubject<URL?>(value: nil)
    let playlistAverageColor = BehaviorSubject<UIColor>(value: .white)
    
    let tracks = Variable<[Track]>([])
    
    // Track information
    private var nextTracksUrl: String?
    private var isLoadingTracks = false
    private var hasMoreTracks = true
    
    
    // MARK: - Lifecycle
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init()
        
        // Set playlist default informations
        DispatchQueue.main.async {
            self.playlistName.onNext(playlist.title)
            self.playlistAuthor.onNext(playlist.creatorName)
            if let duration = playlist.duration.toFormattedString() {
                self.playlistDuration.onNext(duration)
            }
            if let url = playlist.xlPictureUrl {
                self.playlistCover.onNext(url)
            }
            if let averageColor = playlist.mediumPictureAverageColor {
                self.playlistAverageColor.onNext(averageColor)
            }
        }
        if playlist.mediumPictureAverageColor == nil, let mediumPicture = playlist.mediumPicture {
            DispatchQueue.global(qos: .background).async {
                let averageColor = mediumPicture.averageColor
                DispatchQueue.main.async {
                    playlist.mediumPictureAverageColor = averageColor
                    self.playlistAverageColor.onNext(averageColor)
                }
            }
        }
        
        // Load playlist first tracks
        self.loadNextTracks()
    }
    
    func loadNextTracks() {
        if !self.isLoadingTracks && hasMoreTracks {
            self.isLoadingTracks = true
            DeezerService.playlistTracks(playlistId: playlist.id, nextUrl: self.nextTracksUrl) { (tracks, nextUrl) in
                self.isLoadingTracks = false
                self.tracks.value.append(contentsOf: tracks)
                self.nextTracksUrl = nextUrl
                self.hasMoreTracks = nextUrl != nil
            }
        }
    }
    
}
