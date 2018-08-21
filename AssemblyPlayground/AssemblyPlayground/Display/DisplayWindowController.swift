//
//  DisplayWindowController.swift
//  AssemblyPlayground
//
//  Created by Felix Wehnert on 21.08.18.
//  Copyright © 2018 Felix Wehnert. All rights reserved.
//

import AppKit

class DisplayWindowController: NSWindowController {
    override func windowDidLoad() {
        window?.delegate = self
    }
}

extension DisplayWindowController: NSWindowDelegate {

    func windowWillClose(_ notification: Notification) {
        NSApp.stopModal()
    }
    
}