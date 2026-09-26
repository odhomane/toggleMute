import Foundation
import AppKit

/// Manages compatibility with third-party apps that have their own microphone muting.
/// Prevents toggleMute from interfering with apps like Microsoft Teams that maintain
/// independent mute state from the system level.
enum AppCompatibilityController {
    
    // MARK: - Configuration
    
    /// List of bundle identifiers for apps that should be excluded from toggleMute control
    /// when they are the focused/frontmost application.
    private static let excludedAppBundleIDs = [
        "com.microsoft.teams",                    // Microsoft Teams
        "com.microsoft.teams.osx",                // Microsoft Teams (alternative)
        "com.google.Chrome",                      // Google Meet (in Chrome)
        "org.mozilla.firefox",                    // Google Meet/Zoom (in Firefox)
        "com.apple.Safari",                       // Google Meet/Zoom (in Safari)
        "us.zoom.xos",                            // Zoom
        "com.slack.macOS",                        // Slack
        "org.jitsi.jitsi-meet",                   // Jitsi Meet
        "com.discord.mainapp",                    // Discord
    ]
    
    // MARK: - Public API
    
    /// Determines if toggleMute should be prevented from changing mute state
    /// because a compatible app has its own independent mute control.
    ///
    /// Returns true if the frontmost app is in the exclusion list and
    /// "respect app muting" is enabled in preferences.
    static func shouldSkipMutingDueToActiveApp(_ preferences: Preferences) -> Bool {
        guard preferences.respectAppMutingEnabled else { return false }
        
        let frontmostApp = NSWorkspace.shared.frontmostApplication
        guard let bundleID = frontmostApp?.bundleIdentifier else { return false }
        
        return excludedAppBundleIDs.contains(bundleID)
    }
    
    /// Gets the name of the currently focused app, if it's in the exclusion list.
    /// Used for user-facing notifications.
    static func focusedExcludedAppName() -> String? {
        let frontmostApp = NSWorkspace.shared.frontmostApplication
        guard let bundleID = frontmostApp?.bundleIdentifier else { return nil }
        
        guard excludedAppBundleIDs.contains(bundleID) else { return nil }
        
        return frontmostApp?.localizedName ?? bundleID
    }
}
