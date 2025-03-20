//
//  MainWindowsController.swift
//  AstroJourney
//
//  Created by Vic on 21.03.2025.
//

import Cocoa

final class MainWindowController: NSWindowController {
    
    // MARK: - SplitView
    
    // MARK: - Initialzation
    convenience init() {
        // Создаем главное окно
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1180, height: 760),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "Astro Journey"
        window.center()
        window.isReleasedWhenClosed = false
        window.minSize = NSSize(width: 960, height: 760)
        window.setFrameAutosaveName("MainWindow")
        
        self.init(window: window)
    }
    
    // MARK: - Window lifecycle
    override func windowDidLoad() {
        super.windowDidLoad()
        // Do view setup here.
    }
    
}
