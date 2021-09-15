//
//  AppDelegate.swift
//  JOYTT
//
//  Created by apple on 2021/8/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            // Enable or disable features based on authorization
        }
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("token is \(token)")
        TokenManager.shared.set(key: .pushToken, token: token)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // handle push while app is in the foreground
        // 接收通知的 code 。分為本地通知、遠端通知，判斷後呼叫對應的 func
        let request = notification.request // 收到推播的請求
        let content = request.content // 推播的內容
        let userInfo = content.userInfo // 收到的用戶基本訊息，包含 badge sound subtitle title body
        if let userInfo = userInfo as? [String: Any] {
            print("receive apns: \(userInfo)")
        }
        completionHandler([.banner, .list, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // if you set a member variable in didReceiveRemoteNotification, you will know if this is from closed or background
        // 通知的點擊事件。分為本地通知、遠端通知，判斷後呼叫對應的 func
        if let userInfo = response.notification.request.content.userInfo as? [String: Any] {
                print("tap userInfo: \(userInfo)")
        }
    }
}

