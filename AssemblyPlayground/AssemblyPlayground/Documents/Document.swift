//
//  Document.swift
//  AssemblyPlayground
//
//  Created by Felix Wehnert on 16.08.18.
//  Copyright © 2018 Felix Wehnert. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    var data: DocumentData = DocumentData()
    weak var mainWindowController: MainWindowController?
    
    static var current: Document? {
        return (NSApp.mainWindow?.windowController as? MainWindowController)?.document as? Document
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let mainWindowController = storyboard.instantiateController(withIdentifier: "DocumentWindowController") as? MainWindowController else {
            fatalError("Wrong MainWindowController")
        }
        self.mainWindowController = mainWindowController
        self.addWindowController(mainWindowController)
        mainWindowController.setupEngine(emulationMode: self.data.emulationMode)
    }
    
    func changeEmulationMode(to emulationMode: EmulationMode) {
        self.data.emulationMode = emulationMode
        self.mainWindowController?.setupEngine(emulationMode: emulationMode)
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override fileWrapper(ofType:), write(to:ofType:), or write(to:ofType:for:originalContentsURL:) instead.
        do {
            return try JSONEncoder().encode(data)
        } catch {
            throw error
        }
    }

    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type, throwing an error in case of failure.
        // Alternatively, you could remove this method and override read(from:ofType:) instead.
        // If you do, you should also override isEntireFileLoaded to return false if the contents are lazily loaded.
        do {
            self.data = try JSONDecoder().decode(DocumentData.self, from: data)
        } catch {
            throw error
        }
    }
}



