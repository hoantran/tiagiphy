//
//  Constants.swift
//  TiaGiphy
//
//  Created by Hoan Tran on 2/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

import Foundation

struct Constants {
  static let initialGifCount = 12
  static let gifIncrementCount = 4 // raise this number for faster scrolling down
  
  // ImageCache
  static let imageCacheCountLimit = 50
  static let imageCacheMemoryLimit = 20*1024*1024 // maximum memory: 20 MB
  
  // SwiftyGifManager
  static let gifManagerMemoryLimitInMB = 50
}
  
