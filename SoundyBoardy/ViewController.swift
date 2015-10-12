//
//  ViewController.swift
//  SoundyBoardy
//
//  Created by Scott Williams on 10/10/15.
//  Copyright © 2015 swilliams. All rights reserved.
//

import Cocoa

let allowedExtensions = ["wav", "aiff"]

class ViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var dropView: DropView!
    private var soundClipPaths: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.registerClass(ClipCell.self, forItemWithIdentifier: "ClipCell")
        Swift.print("coll: \(collectionView)")
        let dragTypes = [kUTTypeFileURL as String]
        dropView.registerForDraggedTypes(dragTypes)

        // Do any additional setup after loading the view.
        let layer = CALayer()
        layer.backgroundColor = NSColor.blueColor().CGColor
        dropView.wantsLayer = true
        dropView.layer = layer;

        dropView.filesDropped = { [weak self] (dragInfo: NSDraggingInfo) in
            self?.createListOfSoundClipsFromDragInfo(dragInfo)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func createListOfSoundClipsFromDragInfo(dragInfo: NSDraggingInfo) {
        if let draggedFilenames = dragInfo.draggingPasteboard().propertyListForType(NSFilenamesPboardType) as? [NSString] {
            let filteredFiles: [NSString] = draggedFilenames.filter({ allowedExtensions.contains($0.pathExtension) })
            soundClipPaths = filteredFiles.map { $0 as String }
            collectionView.reloadData()
        }
        Swift.print("paths: \(soundClipPaths)")
    }

    //pragma mark: - CollectionView
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5;
        return soundClipPaths.count
    }

    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItemWithIdentifier("SoundClipCell", forIndexPath: indexPath)

        let container = SoundClipContainer(URL: NSURL(fileURLWithPath: soundClipPaths[indexPath.item]))
        cell.representedObject = container
        Swift.print("got cell")
        return cell
    }

    func collectionView(collectionView: NSCollectionView, didSelectItemsAtIndexPaths indexPaths: Set<NSIndexPath>) {
        Swift.print("clicky")
    }
}

