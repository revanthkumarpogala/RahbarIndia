//
//  AppDelegate.swift
//  Rahbar India
//
//  Created by revanth kumar on 03/03/26.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseMessaging
import UserNotifications

let gcmMessageIDKey = "gcm.Message_ID"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.isEnabled = true
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self

        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]) { granted, error in
            print("Permission:", granted)
        }

        UIApplication.shared.registerForRemoteNotifications()
        
        if let userInfo = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
            print("App opened from notification:", userInfo)
        }
        
        return true
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

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        Messaging.messaging().apnsToken = deviceToken

        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let apnsToken = tokenParts.joined()
        print("APNS Token:", apnsToken)
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {

        print("Push registration failed:", error.localizedDescription)
    }
}


extension AppDelegate: MessagingDelegate {

//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//
//        print("FCM Token:", fcmToken ?? "")
//        
//        // Send this token to your backend server
//        
//        guard let token = fcmToken else { return }
//        // Save token locally
//           UserDefaults.standard.set(token, forKey: "fcm_token")
//           UserDefaults.standard.synchronize()
//    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        guard let token = fcmToken else { return }

        print("FCM Token:", token)

        UserDefaults.standard.set(token, forKey: "fcm_token")

        // If user already logged in
        if let user = UserSessionManager.shared.getUser() {

            let userId = "\(user.id)"

            AuthService.shared.updateFCMToken(
                fcmToken: token,
                userId: userId
            ) { result in
                print("Auto FCM update:", result)
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

func userNotificationCenter(_ center: UNUserNotificationCenter,
                            willPresent notification: UNNotification) async
-> UNNotificationPresentationOptions {

    return [.alert, .sound, .badge]
}
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        // ...
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
}
