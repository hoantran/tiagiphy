//
//  AppDelegate.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import UIKit
import SwiftyGif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(rootViewController: MainController())
//    let gifManager = SwiftyGifManager(memoryLimit:Constants.gifManagerMemoryLimitInMB)
//    let imageCache = ImageCache()
//    let imageData = ImageData(type: "gif", id: "", url: "", image_original_url: "", image_url: "", image_mp4_url: "", image_frames: "", image_width: "542", image_height: "297", fixed_height_downsampled_url: "", fixed_height_downsampled_width: "", fixed_height_downsampled_height: "", fixed_width_downsampled_url: "", fixed_width_downsampled_width: "", fixed_width_downsampled_height: "", fixed_height_small_url: "https://media3.giphy.com/media/l2JJxQqgQMxToZovC/100.gif", fixed_height_small_still_url: "", fixed_height_small_width: "", fixed_height_small_height: "", fixed_width_small_url: "", fixed_width_small_still_url: "", fixed_width_small_width: "", fixed_width_small_height: "", username: "", caption: "")
//    let meta = MetaData(status: 200, msg: "", response_id: "")
//    let giphy = GiphyData(data: imageData, meta: meta)
//
//    let controller = DetailController()
//    controller.swiftyGifManager = gifManager
//    controller.cache = imageCache
//    controller.giphy = giphy
//
//    window?.rootViewController = UINavigationController(rootViewController: controller)
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }


}

