//
//  ViewController.swift
//  Playlists
//
//  Created by Damien Dorizy on 23/09/2017.
//  Copyright © 2017 CfApps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaylistsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    private let viewModel = PlaylistsViewModel()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Ensures items are correctly distributed on the device screen, should it be on iPhone or iPad.
        // On most iPhone there will be 3 columns except on iPhone 5 screen where the items would be too small
        let numberOfItems = Int((self.collectionView.frame.width - 10) / 120)
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (self.collectionView.frame.width - 10) / CGFloat(numberOfItems)
            layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send selected playlist to the next view conctroller
        if let playlistDetailsViewController = segue.destination as? PlaylistDetailsViewController, let playlist = sender as? Playlist {
            playlistDetailsViewController.loadWithPlaylist(playlist)
        }
    }
    
    
    // MARK: - Configuration methods
    
    private func configureCollectionView() {
        self.collectionView.rx
            .modelSelected(Playlist.self)
            .subscribe(onNext: { playlist in
                self.performSegue(withIdentifier: "showPlaylist", sender: playlist)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func bindViewModel() {
        viewModel.playlists.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: PlaylistCell.Identifier, cellType: PlaylistCell.self)) { row, data, cell in
                cell.playlist = data
            }.addDisposableTo(disposeBag)
    }

}
