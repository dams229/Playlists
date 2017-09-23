//
//  PlaylistCell.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaylistCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static var Identifier = "playlistCell"
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - Properties
    
    var playlist: Playlist? {
        didSet {
            guard let playlist = playlist else {
                return
            }
            self.titleLabel.text = playlist.title
            if let pictureUrl = playlist.mediumPictureUrl {
                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: self.playlistImageView.frame.size,
                    radius: 10
                )
                self.playlistImageView.af_setImage(withURL: pictureUrl, filter: filter, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: { (response) in
                    playlist.mediumPicture = response.result.value
                })
            }
            else {
                self.playlistImageView.image = nil
            }
            
        }
    }
    
}
