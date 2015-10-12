//
//  SoundClipView.swift
//  SoundyBoardy
//
//  Created by Scott Williams on 10/11/15.
//  Copyright © 2015 swilliams. All rights reserved.
//

import Cocoa

class SoundClip: NSCollectionViewItem {

    var soundClipContainer: SoundClipContainer? {
        return representedObject as? SoundClipContainer
    }

    @IBOutlet weak var titleLabel: NSTextField!

    @IBAction func playClicked(sender: AnyObject) {
        Swift.print("click \(self.representedObject)")
        soundClipContainer?.play()
    }

    @IBAction func stopClicked(sender: AnyObject) {
        soundClipContainer?.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
