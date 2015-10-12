//
//  DropView.swift
//  SoundyBoardy
//
//  Created by Scott Williams on 10/10/15.
//  Copyright © 2015 swilliams. All rights reserved.
//

import Cocoa

typealias AudioFileDroppedBlock = (draggingInfo: NSDraggingInfo) -> ()

class DropView: NSView {

    var filesDropped: AudioFileDroppedBlock?

    override func awakeFromNib() {
        super.awakeFromNib()
        Swift.print("hiya")
    }

    override func draggingEntered(sender: NSDraggingInfo) -> NSDragOperation {
        Swift.print("drag enter")
        if dragSenderHasValidFile(sender) {
            return .Copy
        }
        return .None
    }

    override func draggingEnded(sender: NSDraggingInfo?) {
        Swift.print("drag end")
        if let sender = sender where dragSenderHasValidFile(sender) {
            filesDropped?(draggingInfo: sender)
        }
    }

    private func dragSenderHasValidFile(sender: NSDraggingInfo) -> Bool {
        if let draggedFilenames = sender.draggingPasteboard().propertyListForType(NSFilenamesPboardType) as? [NSString] {
            for filename: NSString in draggedFilenames {
                if allowedExtensions.contains(filename.pathExtension) {
                    return true
                }
            }
        }
        return false
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let layer = CALayer()
        layer.backgroundColor = NSColor.clearColor().CGColor
        self.wantsLayer = true
        self.layer = layer
    }


}
