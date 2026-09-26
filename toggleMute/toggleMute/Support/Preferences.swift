import Foundation
import LaunchAtLogin

struct Preferences {

    static let didChangeNotification = Notification.Name("com.toggleMute.PreferencesChanged")

    private var defaults = UserDefaults.standard

    private func didChange() {
        NotificationCenter.default.post(name: Self.didChangeNotification, object: nil)
    }

    var launchAtLoginEnabled: Bool {
        get { LaunchAtLogin.isEnabled }
        set {
            LaunchAtLogin.isEnabled = newValue
            didChange()
        }
    }

    var pushToTalkEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var hudEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var hudAlwaysVisible: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var hudRedIconEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var hudShowDeviceName: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var muteInputVolumeEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    var soundsEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }

    /// When enabled, prevents toggleMute from changing mute state when certain apps
    /// (Teams, Zoom, etc.) are focused, since they maintain their own independent
    /// microphone muting that can conflict with system-level muting.
    var respectAppMutingEnabled: Bool {
        get { defaults.bool(forKey: #function) }
        set {
            defaults.set(newValue, forKey: #function)
            didChange()
        }
    }
}
