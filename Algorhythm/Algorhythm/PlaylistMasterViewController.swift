//
//  ViewController.swift
//  Algorhythm
//
//  Created by Javi Manzano on 17/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import UIKit

class PlaylistMasterViewController: UIViewController {

    @IBOutlet weak var playlistImageView0: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let playlist = Playlist(index: 0)
        playlistImageView0.image = playlist.icon

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaylistDetail" {
            let playListDetailController = segue.destinationViewController as PlaylistDetailViewController
            playListDetailController.playlist = Playlist(index: 0)
        }
    }

    @IBAction func showPlaylistDetail(sender: AnyObject) {
        performSegueWithIdentifier("showPlaylistDetail", sender: sender)
    }

}

