//
//  SoundClipContainer.swift
//  SoundyBoardy
//
//  Created by Scott Williams on 10/11/15.
//  Copyright © 2015 swilliams. All rights reserved.
//

import Cocoa
import AVFoundation

class SoundClipContainer: NSObject {
    let fileURL: NSURL
    private var player: AVAudioPlayer?

    var filenameWithoutExtension: String {
        return ((fileURL.absoluteString as NSString).stringByDeletingPathExtension as NSString).lastPathComponent
    }

    init(URL: NSURL) {
        fileURL = URL
        player = try? AVAudioPlayer(contentsOfURL: fileURL)
    }

    func play() {
        player?.currentTime = 0
        player?.play()
    }

    func stop() {
        player?.stop()
    }
}
