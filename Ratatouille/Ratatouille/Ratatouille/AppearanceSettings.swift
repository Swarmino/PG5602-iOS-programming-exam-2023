import Foundation
import SwiftUI

class AppearanceSettings: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            updateAppearance()
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        updateAppearance()
    }
    
    public func updateAppearance() {
        if isDarkMode {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }
    }
}
