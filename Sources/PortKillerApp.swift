import SwiftUI

@main
struct PortKillerApp: App {
    @State private var manager = PortManager()

    init() {
        // Hide from Dock
        NSApplication.shared.setActivationPolicy(.accessory)
    }

    var body: some Scene {
        MenuBarExtra {
            MenuBarView(manager: manager)
        } label: {
            Image(nsImage: menuBarIcon())
        }
        .menuBarExtraStyle(.window)
    }

    private func menuBarIcon() -> NSImage {
        // Try Bundle.module first (works in dev), then fallback to app bundle (works in release)
        let candidates = [
            Bundle.module.url(forResource: "ToolbarIcon", withExtension: "png"),
            Bundle.main.resourceURL?.appendingPathComponent("PortKiller_PortKiller.bundle/ToolbarIcon.png")
        ]

        for candidate in candidates {
            if let url = candidate, let image = NSImage(contentsOf: url) {
                image.size = NSSize(width: 18, height: 18)
                return image
            }
        }
        return NSImage(systemSymbolName: "network.slash", accessibilityDescription: nil) ?? NSImage()
    }
}
