//
//  TrackCell.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    // MARK: - Constants
    
    static var Identifier = "trackCell"
    
    
    // MARK: - IBOutlets
   
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    // MARK: - Properties
    
    var track: Track? {
        didSet {
            guard let track = track else {
                return
            }
            self.trackNameLabel.text = track.title
            self.artistNameLabel.text = track.artist.name
            self.durationLabel.text = track.duration.toFormattedString()
        }
    }

}
