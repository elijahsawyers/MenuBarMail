//
//  MainMailApp.swift
//  Shared
//
//  Created by Elijah Sawyers on 1/19/21.
//

import SwiftUI
import AppAuth

@main
struct MainMailApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainMail()
        }
    }
}

/// Using the `AppDelegate` as there doesn't appear to be a way to add a menu bar item without it yet.
class AppDelegate: NSResponder, NSApplicationDelegate {
    var menuBarItem: NSStatusItem!
    var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.delegate = self
        self.menuBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        configureMenuBarItem()
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        if let authorizationFlow = self.currentAuthorizationFlow,
           let url = urls.first,
           authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.currentAuthorizationFlow = nil
        }
    }
}

/// Extension to configure the menu bar item.
extension AppDelegate {
    func configureMenuBarItem() {
        // Setup the NSMenu.
        self.menuBarItem.menu = Menu()

        // Configure the button image.
        if let button = self.menuBarItem.button {
            button.image = NSImage(systemSymbolName: "envelope", accessibilityDescription: nil)
        }
    }
}
