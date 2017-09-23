//
//  PlaylistDetailsViewController.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaylistDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var playlistInfosView: UIView!
    @IBOutlet weak var playlistInfosViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var playlistImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playlistTitleLabel: UILabel!
    @IBOutlet weak var playlistAuthorLabel: UILabel!
    @IBOutlet weak var playlistDurationLabel: UILabel!
    
    
    // MARK: - Properties
    
    private var viewModel: PlaylistDetailsViewModel!
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTableView()
        self.bindViewModel()
        
        // Add a background shadow on the playlist infos view
        self.playlistInfosView.layer.shadowColor = UIColor.black.cgColor
        self.playlistInfosView.layer.shadowOpacity = 0.3
        self.playlistInfosView.layer.shadowRadius = 2
        self.playlistInfosView.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    /// Creates the PlaylistDetails model
    func loadWithPlaylist(_ playlist: Playlist) {
        self.viewModel = PlaylistDetailsViewModel(playlist: playlist)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Reposition the tableView content inset according to device size and orientation
        let topEdgeInsets = min(self.playlistImageView.frame.width + self.playlistInfosView.frame.height, self.view.frame.height - 100)
        self.tableView.contentInset = UIEdgeInsets(top: topEdgeInsets, left: 0, bottom: 0, right: 0)
    }
    
    
    // MARK: - Configuration methods
    
    private func configureTableView() {
        // Table view cells are calculated automatically, though in this case all have the same height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 55
        
        // Listens to tableview scroll so the top views' positions can be adjusted
        self.tableView.rx.contentOffset.asDriver().drive(onNext: { (point) in
            // Adjust top views positions
            let topSpace = -point.y - self.playlistInfosView.frame.height
            self.playlistInfosViewTopConstraint.constant = max(0, topSpace)
            self.playlistImageViewHeightConstraint.constant = max(self.view.frame.width, topSpace)
            self.view.layoutIfNeeded()
            
            // Load next tracks if the scroll view reaches the bottom
            if self.tableView.isNearBottomEdge(edgeOffset: 50) {
                self.viewModel.loadNextTracks()
            }
            
        }).addDisposableTo(disposeBag)
    }
    
    private func bindViewModel() {
        // Tracks items
        viewModel.tracks.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: TrackCell.Identifier, cellType: TrackCell.self)) { row, data, cell in
                cell.track = data
            }.addDisposableTo(disposeBag)
        
        // PLaylist's informations
        viewModel.playlistName.bind(to: playlistTitleLabel.rx.text).addDisposableTo(disposeBag)
        viewModel.playlistAuthor.bind(to: playlistAuthorLabel.rx.text).addDisposableTo(disposeBag)
        viewModel.playlistDuration.bind(to: playlistDurationLabel.rx.text).addDisposableTo(disposeBag)
        viewModel.playlistCover.subscribe(onNext: { (element) in
            if let url = element {
                self.playlistImageView.af_setImage(withURL: url, placeholderImage: self.viewModel.playlist.mediumPicture, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false)
            }
        }).addDisposableTo(disposeBag)
        
        // We set the playlist image average color as the playlist infos background
        viewModel.playlistAverageColor.subscribe(onNext: { (color) in
            UIView.transition(with: self.playlistInfosView, duration: 0.2, animations: {
                self.playlistInfosView.backgroundColor = color
                let textColor = color.isLight ? UIColor.darkText : UIColor.white
                self.playlistTitleLabel.textColor = textColor
                self.playlistAuthorLabel.textColor = textColor
                self.playlistDurationLabel.textColor = textColor
            })
        }).addDisposableTo(disposeBag)
    }

}
