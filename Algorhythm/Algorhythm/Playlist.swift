//
//  Playlist.swift
//  Algorhythm
//
//  Created by Javi Manzano on 17/03/2015.
//  Copyright (c) 2015 Javi Manzano. All rights reserved.
//

import Foundation
import UIKit

struct Playlist {

    var title: String?
    var description: String?
    var icon: UIImage?
    var largeIcon: UIImage?
    var backgroundColor: UIColor = UIColor.clearColor()
    var artists: [String] = []

    init(index: Int) {
        let musicLibrary = MusicLibrary().library
        let playlistDictionary = musicLibrary[index]

        title = playlistDictionary["title"] as String!
        description = playlistDictionary["description"] as String!

        let iconName = playlistDictionary["icon"] as String!
        icon = UIImage(named: iconName)

        let largeIconName = playlistDictionary["largeIcon"] as String!
        largeIcon = UIImage(named: largeIconName)

        let colorsDictionary = playlistDictionary["backgroundColor"] as [String: CGFloat]!
        backgroundColor = rgbColorFromDictionary(colorsDictionary)

        artists += playlistDictionary["artists"] as [String]!
    }

    func rgbColorFromDictionary(colorDictionary: [String: CGFloat]) -> UIColor {
        let red = colorDictionary["red"]!
        let green = colorDictionary["green"]!
        let blue = colorDictionary["blue"]!
        let alpha = colorDictionary["alpha"]!

        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

}