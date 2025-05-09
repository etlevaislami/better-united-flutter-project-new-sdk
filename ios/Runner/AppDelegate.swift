import UIKit
import Flutter
import UserNotifications
import KeychainAccess
@main
@objc class AppDelegate: FlutterAppDelegate {
    let KEY_CHAIN_SERVICE_NAME = "flutter_secure_storage_service"
    let KEY_FIRST_TIME = "firstTimeLaunchOccurred"
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if !UserDefaults.standard.bool(forKey: KEY_FIRST_TIME) {
            let keychain = Keychain(service: KEY_CHAIN_SERVICE_NAME)
            do { try keychain.removeAll() } catch {
                print(error.localizedDescription)
            }
            UserDefaults.standard.set(true, forKey: KEY_FIRST_TIME)
        }
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
